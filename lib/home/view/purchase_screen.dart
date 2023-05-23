import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/utils/widgets.dart';

import '../../controller/membership_controller.dart';
import '../../controller/purchase_controller.dart';
import '../../utils/constant.dart';
import '../../utils/images.dart';
import '../../utils/space.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    const double price = 1000;
    var priceFormat = NumberFormat.currency(locale: Get.locale.toString(), symbol: '₩');
    PurchaseController controller = Get.put(PurchaseController());
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
                    onPressed: () {
                      // 결제 로직을 구현하세요.
                      // 사용자가 버튼을 눌렀을 때 호출되는 함수입니다.
                      // 여기에 결제 처리 코드를 작성하세요.
                    },
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
                    onPressed: () {
                      if (controller.products.isEmpty) {
                        showAppDialog('스토어에 연결할 수 없습니다', '잠시 후 다시 시도해주세요');
                      } else {
                        controller.buyProduct(controller.products[0]);
                      }

                    },
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
                    onPressed: () {
                      if (controller.products.isEmpty) {
                        showAppDialog('스토어에 연결할 수 없습니다', '잠시 후 다시 시도해주세요');
                      } else {
                        controller.buyProduct(controller.products[1]);
                      }
                    },
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