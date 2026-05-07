
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_app/core/colorsApp.dart';


class InteractiveForgotPassword extends StatefulWidget {
  const InteractiveForgotPassword({super.key});

  @override
  State<InteractiveForgotPassword> createState() => _InteractiveForgotPasswordState();
}

class _InteractiveForgotPasswordState extends State<InteractiveForgotPassword> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: GestureDetector(
          //onTap: () => Get.to(() => CheckEmail()),
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 12.sp,
              color: ColorsApp.PraimaryMain,
              fontWeight: FontWeight.w500,
              decoration: _isHovering ? TextDecoration.underline : TextDecoration.none,
              decorationColor: ColorsApp.PraimaryMain,
              //decorationThickness: 1.1,
            ),
          ),
        ),
      ),
    );
  }
}
