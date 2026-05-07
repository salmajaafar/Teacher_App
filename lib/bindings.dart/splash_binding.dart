import 'package:get/get.dart';
import 'package:parent_app/controllers/splashController.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}