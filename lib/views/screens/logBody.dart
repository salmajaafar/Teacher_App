import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parent_app/controllers/login_controller.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'package:parent_app/views/screens/InteractiveForgotPassword.dart';
import 'package:parent_app/views/widget/buttonStyle.dart';
import 'package:parent_app/views/widget/custom_text_feild.dart';
import 'package:parent_app/views/widget/logo.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return SingleChildScrollView(
      
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 574.w),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                const Center(child: Logo()),
                SizedBox(height: 40.h),

               
                Text(
                  'Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: ColorsApp.bgSoftPeach,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hint: 'Enter your number',
                  controller: authController.Number,
                ),

                SizedBox(height: 20.h),

                
                Text(
                  'PASSWORD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: ColorsApp.bgSoftPeach,
                  ),
                ),
                SizedBox(height: 8.h),

                
                Obx(() => CustomTextField(
                      hint: 'Enter your password',
                      isPassword: authController.isPasswordHidden.value,
                      controller: authController.password,
                    )),

                 SizedBox(height: 60.h),

               
                Obx(() => authController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        textButton: 'Log In',
                        textColor: ColorsApp.bgPureWhite,
                        onPressed: () => authController.login(),
                        width: double.infinity,
                      )),
                SizedBox(height: 20.h),

               Center(
                  
                  child: InteractiveForgotPassword(),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
