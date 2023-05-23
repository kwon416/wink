import 'dart:io';

import 'constant.dart';

class AdHelper {
  //배너형 광고
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return androidTestBannerAdId;
    } else if (Platform.isIOS) {
      return iosTestBannerAdId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
  //전면형 광고
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return androidTestInterstitialAdId;
    } else if (Platform.isIOS) {
      return iosTestInterstitialAdId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
  //리워드형 광고
  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return androidTestRewardedAdId;
    } else if (Platform.isIOS) {
      return iosTestRewardedAdId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}