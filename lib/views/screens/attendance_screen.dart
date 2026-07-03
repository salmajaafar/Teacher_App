// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:parent_app/controllers/attendance_controller.dart';
// import 'package:parent_app/core/AppData.dart';
// import 'package:parent_app/core/colorsApp.dart';
// import 'package:parent_app/views/widget/buttonStyle.dart';
// import 'package:parent_app/views/widget/class_pill_selector.dart';
// import 'package:parent_app/views/widget/section_label.dart';
// import 'package:parent_app/views/widget/semi_circle_header.dart';

// class AttendanceScreen extends StatelessWidget {
//   const AttendanceScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final c = Get.put(AttendanceController());

//     return Scaffold(
//       backgroundColor: ColorsApp.creamBase,
//       body: Column(
//         children: [
//           const SemiCircleHeader(
//             title: 'ATTENDANCE',
//             subtitle: 'XX/YY/ZZZZ',
//           ),
//           const SectionLabel(
//             'CHOOSE THE GRADE, SECTION, AND SUBJECT YOU WANT TO ENTER THE ATTENDANCE FOR:',
//           ),
//           Obx(() => ClassPillSelector(
//                 pills: AppData.classPills,
//                 selectedIndex: c.selectedPillIndex.value,
//                 onSelected: (i) => c.selectedPillIndex.value = i,
//               )),
//           Padding(
//             padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'STUDENT NAME',
//                     style: TextStyle(
//                       fontFamily: 'KiwiMaru',
//                       fontSize: 11.sp,
//                       fontWeight: FontWeight.w800,
//                       color: ColorsApp.textDarkBrown,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   'STATUS',
//                   style: TextStyle(
//                     fontFamily: 'KiwiMaru',
//                     fontSize: 11.sp,
//                     fontWeight: FontWeight.w800,
//                     color: ColorsApp.textDarkBrown,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Obx(() => ListView.builder(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w),
//                   itemCount: c.students.length,
//                   itemBuilder: (_, i) {
//                     final s = c.students[i];
//                     final isPresent = s.status == AttendanceStatus.present;
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: 10.h),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               s.name,
//                               style: TextStyle(
//                                 fontFamily: 'KiwiMaru',
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.w600,
//                                 color: ColorsApp.textDarkBrown,
//                               ),
//                             ),
//                           ),
//                           _statusBtn(
//                             label: 'PRESENT',
//                             active: isPresent,
//                             color: ColorsApp.presentGreen,
//                             onTap: () => c.setStatus(i, AttendanceStatus.present),
//                           ),
//                           SizedBox(width: 6.w),
//                           _statusBtn(
//                             label: 'ABSENT',
//                             active: !isPresent,
//                             color: ColorsApp.absentRed,
//                             onTap: () => c.setStatus(i, AttendanceStatus.absent),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 )),
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
//             child: CustomButton(
//               width: double.infinity,
//               textButton: 'Send Attendance',
//               onPressed: c.sendAttendance,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _statusBtn({
//     required String label,
//     required bool active,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//         decoration: BoxDecoration(
//           color: active ? color : color.withOpacity(0.25),
//           borderRadius: BorderRadius.circular(50.r),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             color: ColorsApp.bgPureWhite,
//             fontSize: 9.sp,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:parent_app/controllers/attendance_controller.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'package:parent_app/views/widget/buttonStyle.dart';
import 'package:parent_app/views/widget/class_pill_selector.dart';
import 'package:parent_app/views/widget/section_label.dart';
import 'package:parent_app/views/widget/semi_circle_header.dart';
import 'package:parent_app/views/widget/status_button.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AttendanceController());

    return Scaffold(
      backgroundColor: ColorsApp.creamBase,
      body: SafeArea(
        child: Obx(
          () => CustomScrollView(
            slivers: [
              /// HEADER
              SliverToBoxAdapter(
                child: SemiCircleHeader(
                  title: 'ATTENDANCE',
                  subtitle: c.formattedDate,
                ),
              ),

              /// LABEL
              const SliverToBoxAdapter(
                child: SectionLabel(
                  'CHOOSE THE GRADE, SECTION, AND SUBJECT YOU WANT TO ENTER THE ATTENDANCE FOR:',
                ),
              ),

              /// CLASS SELECTOR
              SliverToBoxAdapter(
                child: c.isLoadingClasses.value
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      )
                    : ClassPillSelector(
                        pills: c.classPills,
                        selectedIndex: c.selectedPillIndex.value,
                        onSelected: c.onClassSelected,
                      ),
              ),

              /// TABLE HEADER
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'STUDENT NAME',
                          style: TextStyle(
                            fontFamily: 'KiwiMaru',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w800,
                            color: ColorsApp.textDarkBrown,
                          ),
                        ),
                      ),
                      Text('STATUS',
                          style: TextStyle(
                            fontFamily: 'KiwiMaru',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w800,
                            color: ColorsApp.textDarkBrown,
                          )),
                    ],
                  ),
                ),
              ),

              /// STUDENTS LIST
              if (c.isLoadingStudents.value)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (c.students.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: Text("No students found")),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final student = c.students[i];
                      final isPresent =
                          student.status == AttendanceStatus.present;

                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          16.w,
                          0,
                          16.w,
                          10.h,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                student.name,
                                style: TextStyle(
                                  fontFamily: 'KiwiMaru',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsApp.textDarkBrown,
                                ),
                              ),
                            ),
                            StatusBtn(
                              label: 'PRESENT',
                              active: isPresent,
                              color: ColorsApp.presentGreen,
                              onTap: () {
                                c.setStatus(i, AttendanceStatus.present);
                              },
                            ),
                            SizedBox(width: 6.w),
                            StatusBtn(
                              label: 'ABSENT',
                              active: !isPresent,
                              color: ColorsApp.absentRed,
                              onTap: () {
                                c.setStatus(i, AttendanceStatus.absent);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: c.students.length,
                  ),
                ),

              /// BUTTON
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 10, 20.w, 20.h),
                  child: CustomButton(
                    width: double.infinity,
                    textButton: c.isSendingAttendance.value
                        ? 'Sending...'
                        : 'Send Attendance',
                    onPressed: () async {
                      if (c.isSendingAttendance.value) return;
                      await c.sendAttendance();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}