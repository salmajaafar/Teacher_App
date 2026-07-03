import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_app/core/colorsApp.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'KiwiMaru',
        fontSize: 16.sp,
        fontWeight: FontWeight.w800,
        color: ColorsApp.textDarkBrown,
        letterSpacing: 1,
      ),
    );
  }
}
