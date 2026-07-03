import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parent_app/views/screens/advertisements_screen.dart';
import 'package:parent_app/views/screens/homework_screen.dart';
import 'package:parent_app/views/screens/notes_screen.dart';
import 'dart:convert';

import 'package:parent_app/views/screens/what_was_given_screen.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  
  // UI observable data
  var teacherName = "".obs;
  var announcements = <dynamic>[].obs;
  var isLoading = true.obs;
  var carouselIndex = 0.obs;

  // Schedules data as seen in the UI
  final schedules = ['Semester Exam Schedule', 'Weekly Work Schedule'].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeScreenData();
  }

  Future<void> fetchHomeScreenData() async {
    isLoading.value = true;
    try {
      final token = box.read('accessToken');
      const String apiUrl = 'https://satiable-paternity-darkness.ngrok-free.dev/api/Teacher/HomeScreen';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        teacherName.value = data['teacherName'];
        announcements.value = data['announcements'];
      } else {
        Get.snackbar('Error', 'Failed to load home data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Connection error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onCarouselChanged(int index) {
    carouselIndex.value = index;
  }

  void openAdvertisements() {
    // Logic to open advertisements screen
     Get.to(()=>AdvertisementsScreen());// Assuming a route for advertisements
  }

  void openLessonsGiven() {
    // Logic to open 'Sending what was given' screen (Lessons Progress)
    Get.to(()=>WhatWasGivenScreen()); // Assuming a route for lessons given/progress
  }

  void openHomework() {
    // Logic to open 'Sending homework or a note' screen (Homework)
    Get.to(()=>HomeworkScreen()); // Assuming a route for homework
  }

  void openStudentNotes() {
    // Logic to open 'Send a note about a student' screen (Student Notes)
     Get.to(()=>NotesScreen());// Assuming a route for student notes
  }

  void openSchedule(int index) {
    // Logic to open a specific schedule based on index
    // You might navigate to a schedule view, passing the schedule type or ID
    if (index >= 0 && index < schedules.length) {
      final scheduleType = schedules[index];
      Get.toNamed('/scheduleView', arguments: scheduleType); // Assuming a route for schedule view
    } else {
      Get.snackbar('Error', 'Invalid schedule selected');
    }
  }
}
