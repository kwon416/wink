import 'package:get/get.dart';
import 'package:wink/model/sample.dart';

class SampleProvider extends GetConnect {
  // Get request
  Future<Response> getUser(int id) => get('http://youapi/users/$id');
  // Post request
  Future<Response> postUser(Map data) => post('http://youapi/users', data);
  // Post request with File
  Future<Response<SampleModel>> postCases(List<int> image) {
    final form = FormData({
      'file': MultipartFile(image, filename: 'avatar.png'),
      'otherFile': MultipartFile(image, filename: 'cover.png'),
    });
    return post('http://youapi/users/upload', form);
  }

  GetSocket userMessages() {
    return socket('https://yourapi/users/socket');
  }

  Future<Response> postPushNotification() async {
    final  header = {
      "Authorization": "key=AAAAzpC9Qmk:APA91bGpWj1uIQJWsj4XSGk9rcBUknFtUose_Pxz0vHYYgtvZ69KFLpHFrOfnUwWVdI71q-r34iwW0fzy7nxvn2WR3YCBUJd53d0RP8wQ353jZDoRpMU50SU0v7zvtlpcNKXF6qnoAzQ",
      "Content-Type": "application/json"
    };
    final body ={
      "to" : "dvIbYRzxCEsNmAhncTCUet:APA91bHDM2i-0RfHiZo7plJPXPSd5H4cbx-FUNXYXl_xWMmk9f4X1e-Jt-rxfmdZ33jx2cx6xOCN1Xslh6uVJKrLAy7QvS7BHf9KToSxgeYikIhth_63Sss3pE7ZO6BWjnTROwckzFct",
      "collapse_key" : "type_a",
      "data" : {
        "body" : "fcm noti body go to notification screen",
        "title": "fcm noti title called by app",
        "payload" : "notification",
        "key_1" : "Select_1",
        "key_2" : "Select_2"
      }
    };
    final response = await post('https://fcm.googleapis.com/fcm/send?', body, headers: header);
    print(response.body);
    print(response.status);
    print(response.statusCode);
    if (response.status.hasError) {
      return Future.error({response.statusText});
    } else {
      return response;
    }
  }
}