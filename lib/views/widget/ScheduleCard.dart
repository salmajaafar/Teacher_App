import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_app/core/colorsApp.dart';

class ScheduleCard extends StatelessWidget {
  final String title;
  final bool isFirst;
  final VoidCallback onTap;

  const ScheduleCard({
    super.key,
    required this.title,
    required this.isFirst,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: isFirst ? 8.w : 0, left: !isFirst ? 8.w : 0),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: ColorsApp.bgSoftPeach,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.calendar_month, color: ColorsApp.PraimaryMain, size: 28.sp),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'KiwiMaru',
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: ColorsApp.textDarkBrown,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Click to view',
              style: TextStyle(
                fontSize: 9.sp,
                color: ColorsApp.textLightBrown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
