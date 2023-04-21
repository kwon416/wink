import 'package:flutter/foundation.dart';

class PlatformDetails {
  static final PlatformDetails _singleton = PlatformDetails._internal();

  factory PlatformDetails(){
    return _singleton;
  }
  //초기화
  PlatformDetails._internal();

  bool get isDesktop =>
      defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.windows;

  bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android;

  bool get isIos => defaultTargetPlatform == TargetPlatform.iOS;

  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

}