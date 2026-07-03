import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parent_app/controllers/notes_controller.dart';
import 'package:parent_app/core/AppData.dart'; // Assuming AppData is for static data like class pills
import 'package:parent_app/core/colorsApp.dart';
import 'package:parent_app/views/widget/class_pill_selector.dart'; // Assuming this widget exists
import 'package:parent_app/views/widget/rounded_labeled_field.dart'; // Assuming this widget exists
import 'package:parent_app/views/widget/section_label.dart'; // Assuming this widget exists
import 'package:parent_app/views/widget/semi_circle_header.dart'; // Assuming this widget exists

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotesController c = Get.put(NotesController());

    return Scaffold(
      backgroundColor: ColorsApp.creamBase,
      body: Column(
        children: [
          const SemiCircleHeader(title: 'NOTES', showBack: true),
          const SectionLabel(
            'CHOOSE THE GRADE, SECTION, AND SUBJECT:',
          ),
          // This section for ClassPillSelector is commented out in the original UI.
          // If it's intended to be used, ensure AppData.classPills and selectedPillIndex are correctly managed.
          // Obx(() => ClassPillSelector(
          //       pills: AppData.classPills,
          //       selectedIndex: c.selectedPillIndex.value,
          //       onSelected: (i) => c.selectedPillIndex.value = i,
          //     )),
          GestureDetector(
            onTap: () => c.selectDate(context), // Allow selecting date
            child: AbsorbPointer(
              child: RoundedLabeledField(
                label: 'DATE :',
                hint: 'XX/YY/ZZZZ',
                controller: c.dateCtrl,
                suffix: Icon(Icons.calendar_today, color: ColorsApp.PraimaryMain, size: 20.sp),
              ),
            ),
          ),
          RoundedLabeledField(
            label: 'SEARCH',
            hint: 'SEARCH HERE........',
            controller: c.searchCtrl,
            suffix: Icon(Icons.search, color: ColorsApp.PraimaryMain, size: 22.sp),
          ),
          const SectionLabel('STUDENTS :'),
          Expanded(
            child: Obx(() {
              if (c.isLoading.value && c.students.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (c.filteredStudents.isEmpty) {
                return const Center(child: Text('No students found.'));
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: c.filteredStudents.length,
                itemBuilder: (_, i) {
                  final student = c.filteredStudents[i];
                  final studentId = student['studentID'] as int; // Assuming studentID is an int
                  // Ensure a TextEditingController exists for this student
                  if (!c.noteCtrls.containsKey(studentId)) {
                    c.noteCtrls[studentId] = TextEditingController();
                  }
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student['studentName'] ?? 'Unknown Student', // Assuming 'studentName' field
                          style: TextStyle(
                            fontFamily: 'KiwiMaru',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorsApp.textDarkBrown,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: c.noteCtrls[studentId], // Link to the specific student's controller
                                decoration: InputDecoration(
                                  hintText: 'NOTE TO THE PARENT....',
                                  filled: true,
                                  fillColor: ColorsApp.bgPureWhite,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.r),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            GestureDetector(
                              onTap: () => c.sendNote(studentId), // Call sendNote with student ID
                              child: CircleAvatar(
                                radius: 22.r,
                                backgroundColor: ColorsApp.PraimaryMain,
                                child: Icon(Icons.send,
                                    color: ColorsApp.bgPureWhite, size: 18.sp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
