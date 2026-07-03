import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_app/core/colorsApp.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final void Function()? onPressed;
  final double? width;

  final IconData? icon;
  final bool iconLeft;

  final Color? backgroundColor;

  final Color? textColor;

  final Color? borderColor;

  final double borderWidth;

  const CustomButton({
    super.key,
    required this.textButton,
    required this.onPressed,
    this.width,
    this.icon,
    this.iconLeft = true,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? ColorsApp.PraimaryMain,
          padding: EdgeInsets.symmetric(vertical: 5.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderWidth,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16.sp,
                color: textColor ?? ColorsApp.bgPureWhite,
              ),
              SizedBox(width: 5.w),
            ],
            Text(
              textButton,
              style: TextStyle(
                fontSize: 16.sp,
                color: textColor ?? ColorsApp.bgPureWhite,
              ),
            ),

            // /// icon right
            // if (icon != null && !iconLeft) ...[
            //   SizedBox(width: 8.w),
            //   Icon(icon, size: 6.sp, color: ColorsApp.backgroundcolor1),
            // ],
          ],
        ),
      ),
    );
  }
}
