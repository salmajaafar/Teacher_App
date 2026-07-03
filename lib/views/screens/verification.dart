import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:parent_app/controllers/verification_controller.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'package:parent_app/views/widget/buttonStyle.dart';
import 'package:parent_app/views/widget/logo.dart';
import 'package:parent_app/views/widget/pineCodeTextField.dart';

class OtpPage extends StatelessWidget {
  final String Number;

  const OtpPage({super.key, required this.Number});

  @override
  Widget build(BuildContext context) {
    final VerifyController controller = Get.put(VerifyController());

    String otpCode = '';

    return Scaffold(
      backgroundColor: ColorsApp.creamBase,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 420.w,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 35.h,
            ),
            decoration: BoxDecoration(
              color: ColorsApp.bgPureWhite,
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// Logo
                const Logo(),

                SizedBox(height: 25.h),

                /// Title
                Text(
                  'Verify Your Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'KiwiMaru',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorsApp.PraimaryMain,
                  ),
                ),

                SizedBox(height: 14.h),

                /// Description
                Text(
                  'A 6-digit code has been sent to your email address.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'KiwiMaru',
                    fontSize: 10.sp,
                    height: 1.6,
                    color: ColorsApp.textLightBrown,
                  ),
                ),

                SizedBox(height: 10.h),

                /// Email
                // Text(
                //   email,
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontFamily: 'KiwiMaru',
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.w600,
                //     color: ColorsApp.dustyRose,
                //   ),
                // ),

                // SizedBox(height: 40.h),

                /// OTP Field
                CustomPinCodeTextField(
                  onChanged: (value) {
                    otpCode = value;
                  },
                ),

                SizedBox(height: 35.h),

                /// Confirm Button
                CustomButton(
                  width: double.infinity,
                  textButton: 'Confirm',
                  onPressed: () {
                    controller.verifyCode(
                      otpCode.trim(),
                      Number.trim(),
                    );
                  },
                ),

                SizedBox(height: 22.h),

                /// Resend
                
                   GestureDetector(
                    onTap: () {
                    //  controller.resendCode(email);
                    },
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            'Resend Code',
                            style: TextStyle(
                              fontFamily: 'KiwiMaru',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorsApp.PraimaryMain,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Icon(Icons.refresh,color: ColorsApp.PraimaryMain,size: 10.sp,)
                        ],
                      ),
                    ),
                    
                  ),
               

                SizedBox(height: 18.h),

                /// Footer text
                Text(
                  "Didn't receive it? Check your spam folder.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'KiwiMaru',
                    fontSize: 13.sp,
                    color: ColorsApp.textLightBrown,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

