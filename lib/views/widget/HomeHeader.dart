import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:parent_app/controllers/home_controller.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'package:parent_app/views/widget/BottomCurveClipper.dart';

class HomeHeader extends StatelessWidget {
  final HomeController controller;
  const HomeHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomCurveClipper(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 36.h),
        color: ColorsApp.PraimaryMain,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WELCOME BACK... 👋',
                    style: TextStyle(
                      fontFamily: 'KiwiMaru',
                      fontSize: 14.sp,
                      color: ColorsApp.bgPureWhite,
                    ),
                  ),
                  Obx(() => Text(
                        controller.teacherName.value.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.bgPureWhite.withOpacity(0.9),
                        ),
                      )),
                ],
              ),
            ),
            Icon(Icons.toggle_on, color: ColorsApp.bgPureWhite, size: 36.sp),
          ],
        ),
      ),
    );
  }
}
