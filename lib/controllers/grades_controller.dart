import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'package:parent_app/controllers/attendance_controller.dart';

final box = GetStorage();

class GradesController extends GetxController {
  late AttendanceController attendanceController;

  var selectedPillIndex = 0.obs;
  var selectedTestType = RxnString();

  final testDateCtrl = TextEditingController();
  final fullMarkCtrl = TextEditingController();

  final fullMarkValue = ''.obs;

  late List<TextEditingController> markCtrls;
  late List<TextEditingController> noteCtrls;

  final String baseUrl =
      "https://satiable-paternity-darkness.ngrok-free.dev/api/Teacher/grades/save";

  /// Test types
  final Map<String, int> testTypeMap = {
    "Quiz": 1,
    "Midterm": 2,
    "Final": 3,
  };

  @override
  void onInit() {
    super.onInit();

    attendanceController = Get.put(AttendanceController());

    fullMarkCtrl.addListener(() {
      fullMarkValue.value = fullMarkCtrl.text;
    });

    final count = attendanceController.students.length;

    markCtrls = List.generate(
      count,
      (_) => TextEditingController(),
    );

    noteCtrls = List.generate(
      count,
      (_) => TextEditingController(),
    );
  }

  String? normalizeDate(String input) {
    final formats = [
      DateFormat('d/M/yyyy'),
      DateFormat('dd/MM/yyyy'),
      DateFormat('d-M-yyyy'),
      DateFormat('dd-MM-yyyy'),
      DateFormat('yyyy-MM-dd'),
      DateFormat('M/d/yyyy'),
      DateFormat('MM/dd/yyyy'),
    ];

    for (final format in formats) {
      try {
        final date = format.parseStrict(input.trim());

        return DateFormat('yyyy-MM-dd').format(date);
      } catch (_) {}
    }

    return null;
  }

  int get subjectId => selectedPillIndex.value + 1;

  int get studentCount =>
      attendanceController.students.length;

  int get examTypeId =>
      testTypeMap[selectedTestType.value] ?? 1;

  int get fullMark =>
      int.tryParse(fullMarkCtrl.text.trim()) ?? 100;

  Future<void> saveGrades() async {
    try {
      final date = normalizeDate(
        testDateCtrl.text.trim(),
      );

      if (date == null) {
        Get.snackbar(
          "Error",
          "Invalid date format",
        );
        return;
      }

      final token = box.read('accessToken');

      final List<Map<String, dynamic>> studentMarks = [];

      for (int i = 0;
          i < attendanceController.students.length;
          i++) {
        final markText = markCtrls[i].text.trim();

        if (markText.isEmpty) continue;

        studentMarks.add({
          "studentID":
              attendanceController.students[i].id,
          "markValue":
              int.tryParse(markText) ?? 0,
          "notes":
              noteCtrls[i].text.trim(),
        });
      }

      if (studentMarks.isEmpty) {
        Get.snackbar(
          "Error",
          "Please enter at least one mark.",
        );
        return;
      }

      final body = {
        "subjectId": subjectId,
        "examTypeId": examTypeId,
        "examDate": date,
        "fullMark": fullMark,
        "studentMarks": studentMarks,
      };

      print("REQUEST BODY => ${jsonEncode(body)}");

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "*/*",
        },
        body: jsonEncode(body),
      );

      print("STATUS => ${response.statusCode}");
      print("RESPONSE => ${response.body}");

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Grades saved successfully",
        );
      } else {
        Get.snackbar(
          "Error",
          response.body.isEmpty
              ? "Unknown error"
              : response.body,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        e.toString(),
      );
    }
  }

  void sendNoteToParent(int i) {
    // Optional
  }

  @override
  void onClose() {
    testDateCtrl.dispose();
    fullMarkCtrl.dispose();

    for (final c in markCtrls) {
      c.dispose();
    }

    for (final c in noteCtrls) {
      c.dispose();
    }

    super.onClose();
  }
}