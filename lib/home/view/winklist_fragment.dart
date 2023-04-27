import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/utils/images.dart';

import '../../utils/constant.dart';


class WinkListFragment extends StatefulWidget {
  const WinkListFragment({Key? key}) : super(key: key);

  @override
  State<WinkListFragment> createState() => _WinkListFragmentState();
}

class _WinkListFragmentState extends State<WinkListFragment> {

  int itemCount = 3;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      // bodyColor: colorScheme.onPrimaryContainer,
      // displayColor: colorScheme.onPrimaryContainer,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        title: Text('받은 WINK'),
      ),
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {Future.delayed(Duration.zero);},
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: appPadding),
                itemCount: itemCount,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 16),
                    width: double.infinity,
                    decoration: boxDecorationRoundedWithShadow(borderRadius.toInt(), backgroundColor: colorScheme.primary),
                    child: ListTile(
                      onTap: () {
                        Get.defaultDialog(
                        );
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
                            placeholder: AssetImage(loading),
                            image: Image.asset(splashLogo, height: 35, width: 20).image,
                          ),
                        ),
                      ),
                      title: Text('익명 $index', style: boldTextStyle(size: 16,color: colorScheme.onPrimary)),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text('ㅁㄴㅇㄹ $index', style: secondaryTextStyle(size: 10, color: colorScheme.onPrimary)),
                      ),
                      trailing: Text('>'),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
