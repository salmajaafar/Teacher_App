import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
enum AttendanceStatus { present, absent }

class Student {
  final int id;
  final String name;
  AttendanceStatus status;

  Student({required this.id, required this.name, this.status = AttendanceStatus.present});
}

class AttendanceController extends GetxController {
  final attendanceDate = DateTime.now();
  var isSendingAttendance = false.obs;
  String get formattedDate =>
  DateFormat('dd/MM/yyyy').format(attendanceDate);
  String get apiDate =>
  DateFormat('yyyy-MM-dd').format(attendanceDate);
  final box = GetStorage();

  // بيانات الصفوف
  var classes = <dynamic>[].obs;
  var selectedPillIndex = 0.obs;
  var isLoadingClasses = true.obs;

  // بيانات الطلاب
  var students = <Student>[].obs;
  var isLoadingStudents = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchClasses();
  }

  // جلب الصفوف
  Future<void> fetchClasses() async {
    isLoadingClasses.value = true;
    try {
      final token = box.read('accessToken');
      const String apiUrl = 'https://satiable-paternity-darkness.ngrok-free.dev/api/Teacher/classes';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        classes.assignAll(data);
        
        // جلب طلاب أول صف تلقائياً بعد تحميل الصفوف
        if (classes.isNotEmpty) {
          fetchStudents(classes[0]['classRoomID']);
        }
      } else {
        Get.snackbar('Error', 'Failed to load classes');
      }
    } catch (e) {
      Get.snackbar('Error', 'Connection error: $e');
    } finally {
      isLoadingClasses.value = false;
    }
  }

  // جلب الطلاب بناءً على ID الصف
  Future<void> fetchStudents(int classRoomId) async {
    isLoadingStudents.value = true;
    students.clear(); // مسح القائمة الحالية
    try {
      final token = box.read('accessToken');
      final String apiUrl = 'https://satiable-paternity-darkness.ngrok-free.dev/api/Teacher/classes/$classRoomId/students';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Student> loadedStudents = data.map((s) => Student(
          id: s['studentID'],
          name: s['fullName'],
          status: AttendanceStatus.present, // القيمة الافتراضية
        )).toList();
        
        students.assignAll(loadedStudents);
      } else {
        Get.snackbar('Error', 'Failed to load students');
      }
    } catch (e) {
      Get.snackbar('Error', 'Connection error: $e');
    } finally {
      isLoadingStudents.value = false;
    }
  }

  // تغيير الصف المختار وجلب طلابه
  void onClassSelected(int index) {
    selectedPillIndex.value = index;
    final int classId = classes[index]['classRoomID'];
    fetchStudents(classId);
  }

  List<String> get classPills => classes.map((c) => c['displayText'] as String).toList();

  void setStatus(int index, AttendanceStatus status) {
    students[index].status = status;
    students.refresh();
  }

   Future<void> sendAttendance() async {

  if (isSendingAttendance.value) return;

  if (students.isEmpty) {
    Get.snackbar(
      'Alert',
      'No students to send attendance for',
    );
    return;
  }

  final token = box.read('accessToken');

  if (token == null || token.toString().isEmpty) {
    Get.snackbar(
      'Error',
      'Please login again',
    );
    return;
  }

  isSendingAttendance.value = true;

  try {

    const String apiUrl =
        'https://satiable-paternity-darkness.ngrok-free.dev/api/Teacher/attendance/save';

    final List<Map<String, dynamic>> attendanceList =
        students.map((student) {
      return {
        "studentID": student.id,
        "status":
            student.status == AttendanceStatus.present
                ? 1
                : 0,
        "notes": ""
      };
    }).toList();

    final Map<String, dynamic> requestBody = {
      "classRoomID":
          classes[selectedPillIndex.value]["classRoomID"],
      "attendanceDate": apiDate,
      "studentAttendances": attendanceList
    };

    print("========== REQUEST ==========");
    print(jsonEncode(requestBody));

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "*/*",
      },
      body: jsonEncode(requestBody),
    );

    print("========== STATUS ==========");
    print(response.statusCode);

    print("========== RESPONSE ==========");
    print(response.body);

    if (response.statusCode == 200 ||
        response.statusCode == 201) {

      Get.snackbar(
        "Success",
        "Attendance saved successfully",
      );

    } else {

      Get.snackbar(
        "Error ${response.statusCode}",
        response.body,
      );
    }

  } catch (e) {

    Get.snackbar(
      "Error",
      e.toString(),
    );

  } finally {

    isSendingAttendance.value = false;
  }
}}