import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs;
  increment() => count++;

  @override
  void onInit() {
    super.onInit();
    count.value = 1;
  }

  @override
  void onClose() {
    count.value = 0;
    super.onClose();
  }

}