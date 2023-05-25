
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/model/wink_api.dart';

import '../utils/constant.dart';

class WinkProvider extends GetConnect {
  static WinkProvider get instance => Get.find();
  late final _prefs;
  @override
  void onInit() async {
    print('wink provider on init...');

    httpClient.defaultDecoder = (val) {
      return WinkApiModel.fromJson(val as Map<String, dynamic>);
    };
    httpClient.baseUrl = apiBaseUrl + apiVersion;
    httpClient.defaultContentType = contentTypeJson;
    httpClient.timeout = Duration(seconds: 100);
    httpClient.maxAuthRetries = 3;

    httpClient.addRequestModifier<dynamic>((request) {
      // request.headers['Content-Type'] = 'application/json';
      return request;
    });
    _prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

///인증 - 엑세스 토큰 발급
  Future<Response<WinkApiModel>> getAuthToken() async {
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers.remove("Authorization");
      // print(request.headers);
      return request;
    });
    var response = await get<WinkApiModel>('/auth/token');
    //todo 컨트롤러로 이동?
    _prefs.setString('accessToken', response.body?.result['accessToken']??'');
    _prefs.setString('refreshToken', response.body?.result['refreshToken']??'');
    return response;
  }
///인증 - 엑세스 토큰 재 발급
  Future<Response<WinkApiModel>> postAuthRefreshToken(Map body) async {
    //todo 컨트롤러로 이동?
    final String refreshToken = _prefs.getString('refreshToken') ?? '';
    Map<String, String> body = {'refreshToken': refreshToken};
    var response = await  post<WinkApiModel>('/auth/refreshToken', body);
    _prefs.setString('accessToken', response.body?.result['accessToken']);
    return response;
  }
///인증 - 엑세스 토큰 만료
  Future<Response<WinkApiModel>> postAuthLogout(Map body) => post('/auth/logout', body);
///회원 - 회원정보 저장
  Future<Response<WinkApiModel>> postUserSave(Map body) {
    final String accessToken = _prefs.getString('accessToken') ?? '';
    var header = {'Authorization': 'Bearer $accessToken'};
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers.addAll(header);
      return request;
    });
    return post('/users', body);
  }
///회원 - 회원정보 수정
  Future<Response<WinkApiModel>> putUserUpdate(Map body) {
    final String accessToken = _prefs.getString('accessToken') ?? '';
    var header = {'Authorization': 'Bearer $accessToken'};
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers.addAll(header);
      return request;
    });
    return put('/users', body);
  }
///회원 - 회원정보 조회(포인트 정보 포함)
///회원 - 회원 탈퇴
///윙크 - 윙크 보내기
  Future<Response<WinkApiModel>> postWinking(Map body) {
    final String accessToken = _prefs.getString('accessToken') ?? '';
    var header = {'Authorization': 'Bearer $accessToken'};
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers.addAll(header);
      return request;
    });
    return post('/winking', body);
  }
  // Future<Response> getMethod(String route, {Map<String, String>? header, Map<String, dynamic>? query}) async {
  //   try {
  //     final response = await get(route, headers: header, query: query);
  //     return response;
  //   } catch (error) {
  //     print(error.toString());
  //     return ;
  //   }
  // }
}