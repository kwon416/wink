import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import
'package:in_app_purchase_storekit/store_kit_wrappers.dart';
//import for GooglePlayProductDetails
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
//import for SkuDetailsWrapper
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:wink/controller/membership_controller.dart';
import 'package:wink/utils/widgets.dart';



/// in app purchase  -> 나중에 서버에서 fetch?
/// consumable -> 인앱에서 소모가능한 재화 등
/// nonConsumable(upgrade) -> 비소모품, 영구 업그레이드 등
/// subscription -> 월별, 년별 구독하기
///
/// 1. IAP Flow
/// 앱에서 인앱결제 호출 -> 영수증 검증 -> 데이터 저장
///
/// 2. product ID
/// IOS: App Store Connect -> 제품 ID
/// Androis: 플레이 콘솔 -> 인앱상품 -> 제품 ID
final bool _kAutoConsume = Platform.isIOS || true;
const String _kConsumableId = 'coin_consumable_10';
const String _kConsumableId2 = 'coin_consumable_30';
// const String _kUpgradeId = 'upgrade';
// const String _kSilverSubscriptionId = 'subscription_silver';
// const String _kGoldSubscriptionId = 'subscription_gold';
const List<String> _kProductIds = <String>[
  _kConsumableId,
  _kConsumableId2,
  // _kUpgradeId,
  // _kSilverSubscriptionId,
  // _kGoldSubscriptionId,
];

class PurchaseController extends GetxController {
  static PurchaseController get instance => Get.find();

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  // List<String> _notFoundIds = <String>[];
  RxList<ProductDetails> products = <ProductDetails>[].obs;
  RxList<PurchaseDetails> purchases = <PurchaseDetails>[].obs;
  // List<String> _consumables = <String>[];
  bool isAvailable = false;
  RxBool purchasePending = false.obs;
  RxBool loadingComplete = false.obs;
  String? _queryProductError;



  ///인앱 구매 스트림 초기화
  @override
  void onInit() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = InAppPurchase.instance.purchaseStream;
    
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) async {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (error) {
        //todo: handle error
        print(error);
      },
    );
    //todo: 데이터 가져오고 초기화하는 걸로 수정하기
    _initStoreInfo();

    super.onInit();
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

  Future<void> _initStoreInfo() async {
    //인앱 결제 가능 확인
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      print('IAP not available');
      products.value = [];
      purchases.value = [];
      purchasePending.value = false;
      return;
    }
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }
    //todo: product list 서버에서 받아와서 -> _kProductIds.toSet()으로 중복 제거 후 판매 상품 로딩
    final ProductDetailsResponse productDetailsResponse = await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailsResponse.error != null) {
      _queryProductError = productDetailsResponse.error!.message;
      products.value = [];
      purchases.value = [];
      purchasePending.value = false;
      _handleError(productDetailsResponse.error!);
      print('IAP error');
      print(_queryProductError);
      return;
    }

    if (productDetailsResponse.notFoundIDs.isNotEmpty) {
      print(productDetailsResponse.notFoundIDs);
      print('IAP not found');
      products.value = [];
      return;
    }

    if (productDetailsResponse.productDetails.isEmpty) {
      _queryProductError = null;
      purchases.value = [];
      purchasePending.value = false;
      print('is empty');
      return;
    }
    print('인앱 결제 활성화');

    products.value = productDetailsResponse.productDetails;
    loadingComplete.value = true;
  }

  //상품 구매 - ui에서 호출
  Future<void> buyProduct(ProductDetails productDetails, {bool consumable = true}) async {
    //IOS: 실패한 거래가 대기열 에 있으면 제거
    if (GetPlatform.isIOS) {
      var paymentWrapper = SKPaymentQueueWrapper();
      var transactions = await paymentWrapper.transactions();
      print("exist transcations in ios purchase? -> $transactions");
      for (var transaction in transactions) {await paymentWrapper.finishTransaction(transaction);}
    }
    print('buyProduct -> $productDetails');
    //판매상품 목록에 판매하는 상품이 있는지 확인
    if (!await _checkSalesList(productDetails)) return;
    final PurchaseParam purchaseParam = _getPurchaseParam(productDetails);

    if (consumable) {
      _buyConsumable(purchaseParam);
    } else {
      // _buyNonConsumable(purchaseParam);
      print('buyProduct -> nonConsumable!');
      return;
    }
  }

  Future<bool> _checkSalesList(ProductDetails productDetails) async {

    //todo: 판매상품 목록에 판매하는 상품이 있는지 확인
    return Future.value(true);
  }

  PurchaseParam _getPurchaseParam(ProductDetails productDetails) {
    return PurchaseParam(productDetails: productDetails);
  }

  //소모성 상품 구매 신청 -> 리스너에서 수신
  void _buyConsumable(PurchaseParam purchaseParam) {
    print('buy consumable');
    _inAppPurchase.buyConsumable(
      purchaseParam: purchaseParam,
      autoConsume: _kAutoConsume || Platform.isIOS,
    );
  }
  //리스너에서 결제 결과에 따른 화면 처리
  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    print('start listener');
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print('purchase pending -- ${purchaseDetails.status}');
        _showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
                   purchaseDetails.status == PurchaseStatus.restored) {
          print('purchasing processing... -- ${purchaseDetails.status}');
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        await _completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> _completePurchase(PurchaseDetails purchaseDetails) async  {
    print('complete purchase -- ${purchaseDetails.status}');
    _unShownPendingUI();
    if (purchaseDetails.pendingCompletePurchase) {
      // bool result = false;
      await _inAppPurchase.completePurchase(purchaseDetails);
    }
  }

  ///구매 검증하기
  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    print('verify purchase -- ${purchaseDetails.status}');
    //구매 id
    print('purchaseId : ${purchaseDetails.purchaseID}');
    // 마켓에 등록한 상품 아이디(문자열)
    print('productId : ${purchaseDetails.productID}');
    // 구매 상태 PurchaseStatus.purchased 형태로 리턴한다 - android
    print('purchase status : ${purchaseDetails.status}');
    // 구매 날짜 1679542316652 형태로 리턴한다 - android
    print('transcation date : ${purchaseDetails.transactionDate}');
    // 에러?
    print('IAPError : ${purchaseDetails.error}');
    //구매 보류?
    print('pending complete purchase : ${purchaseDetails.pendingCompletePurchase}');
    
    // 구매 영수증 검증데이터가 base64로 암호화된 문자열로 리턴된다 - ios
    // 구매 영수증 아래와 같은 형태로 리턴된다 - android
    /*
    {
    "orderId":"주문아이디","
    packageName":"패키지명",
    "productId":"상품 아이디",
    "purchaseTime": 주문시간,
    "purchaseState": 0, // 주문상태
    "purchaseToken": "구매토큰",
    "quantity":1, // 수량
    "acknowledged":false // 정기결제 여부
    }
    */
    print('local verification data : ${purchaseDetails.verificationData.localVerificationData}');
    // print('decoded local verification data : ${utf8.decode(base64.decode(purchaseDetails.verificationData.localVerificationData))}');
    // 안드로이드 구매 토큰
    print('server verification data : ${purchaseDetails.verificationData.serverVerificationData}');
    // print('decode server verification data : ${String.fromCharCodes(base64Decode(base64.normalize(purchaseDetails.verificationData.serverVerificationData)))}');
    // 구매 마켓 안드로이드면 google_play를 리턴한다
    print('store source(market) : ${purchaseDetails.verificationData.source}');

    // _inAppPurchase.getPlatformAddition<InAppPurchasePlatformAddition>()
    ///TODO
    /// 1. 영수증 값(localVerificationData)을 서버에 넘겨 영수증 검증
    /// 2. 결제 여부 db 저장
    /// 3. 앱에 검증 결과 알림
    /// 4. 검증 결과 반환하기 - 테스트이므로 참(반드시 변경 필요)
    print('verifying compelte! is Valid? ---- ${true}');
    return Future.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    print("invalid purchase -- ${purchaseDetails.status}");
    //todo: handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> consume(String id) async {
    // await ConsumableStore.consume(id);
    // final List<String> consumables = await ConsumableStore.load();
    // setState(() {
    //   _consumables = consumables;
    // });
  }

  void _showPendingUI() {
    print('show pending UI');
    showPendingDialog();
    purchasePending.value = true;
  }

  void _unShownPendingUI() {
    print('close pending UI');
    Get.back();
    purchasePending.value = false;
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    MembershipController controller = Get.find();
    print('delevery product -- ${purchaseDetails.status}');
    // IMPORTANT!! Always verify purchase details before delivering the product.
    // TODO: 코인 지급
    if (purchaseDetails.productID == _kConsumableId) {
      controller.addCoin(addCoin: 10);
      // await ConsumableStore.save(purchaseDetails.purchaseID!);
      // final List<String> consumables = await ConsumableStore.load();
      purchasePending.value = false;
      // _consumables = consumables;

    } else {
      purchases.add(purchaseDetails);
      purchasePending.value = false;
    }
  }

  void _handleError(IAPError? error) {
    //Todo: 에러를 ui로 어떻게 보여줄 것인가
    print(error?.code);
    purchasePending.value = false;

  }

  void queryPastPurchases() async {
    if (GetPlatform.isAndroid) {
      final addition = _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final purchases = await addition.queryPastPurchases();
      print(purchases);
    }
    if (GetPlatform.isIOS) {

    }
  }

}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}