import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parent_app/controllers/grades_controller.dart';
import 'package:parent_app/controllers/homework_controller.dart';
import 'package:parent_app/core/AppData.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'package:parent_app/views/widget/buttonStyle.dart';
import 'package:parent_app/views/widget/class_pill_selector.dart';
import 'package:parent_app/views/widget/rounded_labeled_field.dart';
import 'package:parent_app/views/widget/section_label.dart';
import 'package:parent_app/views/widget/semi_circle_header.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeworkController());
final p = Get.put(GradesController());

    return Scaffold(
      backgroundColor: ColorsApp.creamBase,
      body: Column(
        children: [
          const SemiCircleHeader(title: 'HOMEWORK', showBack: true),
          const SectionLabel('CHOOSE THE GRADE, SECTION, AND SUBJECT :'),
          Obx(() => ClassPillSelector(
                pills: p.attendanceController.classPills,
                selectedIndex: c.selectedPillIndex.value,
                onSelected: (i) => c.selectedPillIndex.value = i,
              )),
          RoundedLabeledField(
            label: 'DATE :',
            hint: 'XX/YY/ZZZZ',
            controller: c.dateCtrl,
            suffix: Icon(Icons.calendar_today, color: ColorsApp.PraimaryMain, size: 20.sp),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HOMEWORK TEXT :',
                      style: TextStyle(
                        fontFamily: 'KiwiMaru',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorsApp.textDarkBrown,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: c.homeworkCtrl,
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText:
                            'WRITE THE HOMEWORK REQUIRED FROM THE STUDENTS AND THE SUBMISSION DEADLINE.....',
                        hintStyle: TextStyle(fontSize: 10.sp, height: 1.4),
                        filled: true,
                        fillColor: ColorsApp.bgPureWhite,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: CustomButton(
              width: double.infinity,
              textButton: 'Send to all',
              onPressed: c.sendToAll,
            ),
          ),
        ],
      ),
    );
  }
}
