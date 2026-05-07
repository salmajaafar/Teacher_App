import 'package:get/get.dart';
import 'package:parent_app/views/screens/welcome.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 9), () {
      Get.to(()=> Welcome());
    });
  }
}