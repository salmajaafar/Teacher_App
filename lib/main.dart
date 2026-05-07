import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:parent_app/core/theme/AppTheme.dart';
import 'package:parent_app/routes/app_pages.dart';
import 'package:parent_app/routes/routes.dart';
import 'package:parent_app/views/screens/splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
        
      initialRoute: AppRoutes.splash,
       getPages: AppPages.pages,
          theme: AppTheme.lightTheme,
         
          home:
          
           Splash(), 
        );
      },
    );
  }
}
