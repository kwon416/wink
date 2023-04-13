import 'package:get/get.dart';

class SampleProvider extends GetConnect {

  Future<Response> postPushNotification() async {
    final  header = {
      "Authorization": "key=AAAAzpC9Qmk:APA91bGpWj1uIQJWsj4XSGk9rcBUknFtUose_Pxz0vHYYgtvZ69KFLpHFrOfnUwWVdI71q-r34iwW0fzy7nxvn2WR3YCBUJd53d0RP8wQ353jZDoRpMU50SU0v7zvtlpcNKXF6qnoAzQ",
      "Content-Type": "application/json"
    };
    final body ={
      "to" : "fva3anwrStGj7lx_kwAuln:APA91bFNf2I7slRKun09wQPiJETrB3Tdun4CyWYhCcKP7vnY5PMxbvWiF6E4x5kW5ImTFxRSfJDPvydM2vXTKXvvp9Iq4cRmSDfaOABYlsc2XBVeNIiPAmZ3qeKUbeejcjOh3biu2tWo",
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