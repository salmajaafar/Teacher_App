import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // For date formatting

class NotesController extends GetxController {
  final box = GetStorage();

  // Observables for UI state
  var isLoading = false.obs;
  var students = <Map<String, dynamic>>[].obs; // To store fetched students
  var filteredStudents = <Map<String, dynamic>>[].obs; // To store filtered students
  var noteCtrls = <int, TextEditingController>{}.obs; // Controllers for each student's note
  var selectedClassRoomId = ''.obs; // To hold the selected class ID

  // TextEditingControllers for input fields
  late TextEditingController dateCtrl;
  late TextEditingController searchCtrl;

  @override
  void onInit() {
    super.onInit();
    dateCtrl = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
    searchCtrl = TextEditingController();

    // Listen to search input changes
    searchCtrl.addListener(() {
      searchStudents(searchCtrl.text);
    });

    // Initialize note controllers for existing students (if any)
    ever(students, (_) {
      _initializeNoteControllers();
    });

    // Example: Fetch students for a default class or from arguments
    // In a real app, you'd get this from navigation arguments or a selection.
    // For now, let's assume a default or placeholder class ID.
    // You might want to pass this via Get.arguments when navigating to NotesScreen.
    // For demonstration, let's use a dummy class ID.
    // if (Get.arguments != null && Get.arguments['classRoomId'] != null) {
    //   selectedClassRoomId.value = Get.arguments['classRoomId'];
    //   fetchStudents(selectedClassRoomId.value);
    // } else {
    //   // Handle case where classRoomId is not provided, e.g., show an error or default
    //   Get.snackbar('Error', 'Class Room ID not provided');
    // }
    // For now, let's fetch with a dummy ID to show functionality
    fetchStudents('dummyClassId'); // Replace with actual class ID logic
  }

  @override
  void onClose() {
    dateCtrl.dispose();
    searchCtrl.dispose();
    noteCtrls.forEach((key, value) => value.dispose());
    super.onClose();
  }

  void _initializeNoteControllers() {
    noteCtrls.clear();
    for (var student in students) {
      noteCtrls[student['studentID']] = TextEditingController();
    }
    filteredStudents.value = List.from(students); // Initially, all students are filtered
  }

  Future<void> fetchStudents(String classRoomId) async {
    isLoading.value = true;
    try {
      final token = box.read('accessToken');
      final String apiUrl = 'https://satiable-paternity-darkness.ngrok-free.dev/api/Teacher/classes/$classRoomId/students-search';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        students.value = responseData.map((s) => s as Map<String, dynamic>).toList();
        _initializeNoteControllers(); // Re-initialize note controllers after fetching new students
      } else {
        Get.snackbar('Error', 'Failed to load students: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Connection error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void searchStudents(String query) {
    if (query.isEmpty) {
      filteredStudents.value = List.from(students);
    } else {
      filteredStudents.value = students.where((student) {
        final studentName = student['studentName']?.toLowerCase() ?? ''; // Assuming studentName field
        return studentName.contains(query.toLowerCase());
      }).toList();
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      dateCtrl.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> sendNote(int studentId) async {
    final noteContent = noteCtrls[studentId]?.text.trim();
    if (noteContent == null || noteContent.isEmpty) {
      Get.snackbar('Error', 'Note content cannot be empty');
      return;
    }

    isLoading.value = true;
    try {
      final token = box.read('accessToken');
      const String apiUrl = 'https://satiable-paternity-darkness.ngrok-free.dev/api/Teacher/notes/save';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
        body: jsonEncode({
          'studentID': studentId,
          'noteContent': noteContent,
          'createdAt': DateTime.now().toIso8601String(), // Use ISO 8601 format
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Note sent successfully!');
        noteCtrls[studentId]?.clear(); // Clear the text field after sending
      } else {
        Get.snackbar('Error', 'Failed to send note: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Connection error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
