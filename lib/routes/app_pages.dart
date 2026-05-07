import 'package:get/get.dart';
import 'package:parent_app/views/screens/welcome.dart';
import 'package:parent_app/views/screens/splash.dart';



import 'routes.dart';

class AppPages {
  static final pages = [

    GetPage(
      name: AppRoutes.splash,
      page: () =>  Splash(),
    ),

    GetPage(
      name: AppRoutes.welcome,
      page: () =>  Welcome(),
    ),

    // GetPage(
    //   name: AppRoutes.login,
    //   page: () => const LoginView(),
    // ),

    // GetPage(
    //   name: AppRoutes.signup,
    //   page: () => const SignUpView(),
    // ),
  ];
}