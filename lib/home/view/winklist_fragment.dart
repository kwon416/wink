import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/controller/membership_controller.dart';
import 'package:wink/custom_widget/space.dart';
import 'package:wink/utils/images.dart';

import '../home.dart';

class WinkListFragment extends StatefulWidget {
  const WinkListFragment({Key? key}) : super(key: key);

  @override
  State<WinkListFragment> createState() => _WinkListFragmentState();
}

class _WinkListFragmentState extends State<WinkListFragment> {

  int itemCount = 10;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );

    return GetBuilder<MembershipController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: colorScheme.primaryContainer,
            elevation: 0.3,
            title: Text('받은 WINK', style: textTheme.titleLarge,),

          ),
          backgroundColor: Colors.transparent,
          body: controller.userData?.isVerified ?? false
            ? ListView.builder(
            padding: EdgeInsets.only(bottom: 16),
            itemCount: itemCount,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                width: double.infinity,
                decoration: boxDecorationRoundedWithShadow(8, backgroundColor: colorScheme.primary),
                child: ListTile(
                  onTap: () {
                    // SDLessonsDetScreen(
                    //   name: scoreboardAvailable[index].title,
                    //   backgroundImages: scoreboardAvailable[index].backgroundImages,
                    // ).launch(context);
                  },
                  leading: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    height: 45,
                    width: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage('Loading'),
                        image: Image.asset(splashLogo, height: 35, width: 20).image,
                      ),
                    ),
                  ),
                  title: Text('title', style: boldTextStyle(size: 16,color: colorScheme.onPrimary)),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text('subTitle', style: secondaryTextStyle(size: 10, color: colorScheme.onPrimary)),
                  ),
                  // trailing: CircularPercentIndicator(
                  //   radius: 30.0,
                  //   lineWidth: 3.0,
                  //   animation: true,
                  //   percent: scoreboardAvailable[index].status!.toDouble(),
                  //   backgroundColor: sdViewColor,
                  //   circularStrokeCap: CircularStrokeCap.round,
                  //   progressColor: sdPrimaryColor,
                  // ),
                ),
              );
            },
          )
            : NotVerifiedScreen(),
          // body: ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: 15,
          //   padding: EdgeInsets.all(16),
          //   itemBuilder: (_, index) {
          //     return Container(
          //       decoration: boxDecorationWithRoundedCorners(
          //         backgroundColor: colorScheme.primaryContainer
          //       ),
          //       padding: EdgeInsets.all(16),
          //       child: Row(
          //         children: [
          //           Icon(Icons.outlet),
          //           8.width,
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text('title'),
          //               8.height,
          //               Row(
          //                 children: [
          //                   Text('subtitle'),
          //                   8.width,
          //                   Container(
          //                     decoration: boxDecorationWithRoundedCorners(backgroundColor: Colors.red, boxShape: BoxShape.circle),
          //                     width: 6,
          //                     height: 6,
          //                   ),
          //                   8.width,
          //                   Text('when', style: secondaryTextStyle(size: 12)),
          //                 ],
          //               ),
          //             ],
          //           ).expand()
          //         ],
          //       ),
          //     ).paddingOnly(bottom: 16);
          //   },
          // ),

        );
      }
    );
  }
}
