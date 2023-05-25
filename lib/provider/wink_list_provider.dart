import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/wink_api_list.dart';
import '../utils/constant.dart';

class WinkListProvider extends GetConnect {
  static WinkListProvider get instance => Get.find();
  late final _prefs;
  @override
  void onInit() async {
    print('wink List provider on init...');

    httpClient.defaultDecoder = (val) {
      return WinkApiListModel.fromJson(val as Map<String, dynamic>);
    };
    httpClient.baseUrl = apiBaseUrl + apiVersion;
    // httpClient.defaultContentType = contentTypeJson;
    httpClient.timeout = Duration(seconds: 100);
    httpClient.maxAuthRetries = 3;

    httpClient.addRequestModifier<dynamic>((request) {
      // request.headers['Content-Type'] = 'application/json';
        return request;
      });
    _prefs = await SharedPreferences.getInstance();
      super.onInit();
    }
  ///윙크 - 내가 보낸 내역
  Future<Response<WinkApiListModel>> getWinkSendList(String userId) {
    final String accessToken = _prefs.getString('accessToken') ?? '';
    var header = {'Authorization': 'Bearer $accessToken'};
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers.addAll(header);
      return request;
    });
    return get('/winking/send/$userId');
  }
  ///윙크 - 내가 받은 내역
  Future<Response<WinkApiListModel>> getWinkReceiveList(String userId) {
    final String accessToken = _prefs.getString('accessToken') ?? '';
    var header = {'Authorization': 'Bearer $accessToken'};
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers.addAll(header);
      return request;
    });
    return get('/winking/rcv/$userId');
  }
}