import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';
import 'package:wink/utils/constant.dart';

class DynamicLinks {

  Future<bool> setup() async {
    bool isExistDynamicLink = await _getInitialDynamicLink();
    _addListener();

    return isExistDynamicLink;
  }

  Future<bool> _getInitialDynamicLink() async {
    final String? deepLink = await getInitialLink();

    if (deepLink != null) {
      PendingDynamicLinkData? dynamicLinkData = await FirebaseDynamicLinks
          .instance
          .getDynamicLink(Uri.parse(deepLink));

      if (dynamicLinkData != null) {
        _redirectScreen(dynamicLinkData);

        return true;
      }
    }

    return false;
  }

  void _addListener() {
    FirebaseDynamicLinks.instance.onLink.listen((
        PendingDynamicLinkData dynamicLinkData,
        ) {
      _redirectScreen(dynamicLinkData);
    }).onError((error) {
      // logger.e(error);
      print(error);
    });
  }

  void _redirectScreen(PendingDynamicLinkData dynamicLinkData) {
    if (dynamicLinkData.link.queryParameters.containsKey('id')) {
      String link = dynamicLinkData.link.path.split('/').last;
      String id = dynamicLinkData.link.queryParameters['id']!;

      // switch (link) {
      //   case exhibition:
      //     Get.offAll(
      //           () => ExhibitionDetailScreen(
      //         mainBottomTabIndex: MainBottomTabScreenType.exhibitionMap.index,
      //       ),
      //       arguments: {
      //         "exhibitionId": id,
      //       },
      //     );
      //     break;
      //   case artist:
      //     Get.offAll(
      //           () => ArtistScreen(),
      //       arguments: {
      //         "artistId": id,
      //       },
      //     );
      //     break;
      //   case exhibitor:
      //     Get.offAll(
      //           () => ExhibitorScreen(),
      //       arguments: {
      //         "exhibitorId": id,
      //       },
      //     );
      //     break;
      // }
    }
  }

  Future<String> getShortLink(String screenName, String id) async {
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: dynamicLinkPrefix,
      link: Uri.parse('$dynamicLinkPrefix/$screenName?id=$id'),
      // link: Uri.parse(dynamicLinkPrefix),
      androidParameters: const AndroidParameters(
        packageName: packageName,
        minimumVersion: 0,

      ),
      iosParameters: const IOSParameters(
        bundleId: packageName,
        minimumVersion: '0',

      ),
    );
    final dynamicLink =
    await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    return dynamicLink.shortUrl.toString();
  }

}