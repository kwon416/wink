import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/utils/widgets.dart';

import '../../controller/membership_controller.dart';
import '../../controller/purchase_controller.dart';
import '../../utils/ad_helper.dart';
import '../../utils/constant.dart';
import '../../utils/images.dart';
import '../../utils/space.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {

  RewardedAd? _rewardedAd;

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                _rewardedAd = null;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _rewardedAd = ad;
            print('광고 로드 완료');
          });
        },
        onAdFailedToLoad: (err) {
          //TODO 에러 다이얼로그 추가
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }
  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var priceFormat = NumberFormat.currency(locale: Get.locale.toString(), symbol: '₩');
    PurchaseController controller = Get.find();
    MembershipController membershipController = Get.find();

    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.close, size: 30)
        ),
        title: Text('코인'),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text('사용 내역')
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Space(buttonMargin),
            Image.asset(icHeart, height: iconSizeXLarge,),
            Space(buttonMargin),
            GetBuilder<MembershipController>(
                builder: (memC) {
                  return Text('${memC.userData?.coin} ${'코인'.tr}', style: TextStyle(fontSize: textSizeNormal, fontWeight: FontWeight.bold),);
                }
            ),
            Space(buttonMargin),
            Text(
              '현재 보유 코인',
              style: secondaryTextStyle(),
            ),
            Space(buttonMargin),
            Divider(thickness: 1),
            Padding(
              padding: EdgeInsets.all(appPadding),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _rewardedAd != null
                       ? () {
                      _rewardedAd?.show(
                          onUserEarnedReward: (_, reward) {
                            membershipController.addCoin();
                            print('리워드 지급');
                            }
                      );
                    }
                    : (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(icHeart, height: 24,),
                            Space(buttonPadding),
                            Text('무료 코인'),
                          ],
                        ),
                        FaIcon(FontAwesomeIcons.rectangleAd),
                      ],
                    ),
                  ),
                  Space(buttonMargin),
                  ElevatedButton(
                    onPressed: controller.loadingComplete.value
                        ? () {
                      print('10 코인 구매');
                      if (controller.products.isEmpty) {
                        showAppDialog('스토어에 연결할 수 없습니다', '잠시 후 다시 시도해주세요');
                      } else {
                        controller.buyProduct(controller.products[0]);
                      }

                    }
                    : (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(icHeart, height: 24,),
                            Space(buttonPadding),
                            Text('10 코인'),
                          ],
                        ),
                        Text(priceFormat.format(1100)),
                      ],
                    ),
                  ),
                  Space(buttonMargin),
                  ElevatedButton(
                    onPressed: controller.loadingComplete.value
                       ? () {
                      if (controller.products.isEmpty) {
                        showAppDialog('스토어에 연결할 수 없습니다', '잠시 후 다시 시도해주세요');
                      } else {
                        controller.buyProduct(controller.products[1]);
                      }
                    }
                    : (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(icHeart, height: 24,),
                            Space(buttonPadding),
                            Text('30 코인'),
                          ],
                        ),
                        Text(priceFormat.format(2200)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}