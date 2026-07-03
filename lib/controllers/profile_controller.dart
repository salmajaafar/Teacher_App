import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileController extends GetxController {
  final box = GetStorage();

  // بيانات البروفايل الملاحظة
  var name = "".obs;
  var phone = "".obs;
  var email = "".obs;
  var grades = <String>[].obs;
  var subjects = <String>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    isLoading.value = true;
    try {
      final token = box.read('accessToken');
      const String apiUrl = 'https://satiable-paternity-darkness.ngrok-free.dev/api/Teacher/profile';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // تحديث البيانات من الـ API
        name.value = data['fullName'] ?? "Unknown";
        phone.value = data['phoneNumber'] ?? "N/A";
        email.value = data['email'] ?? "N/A";
        
        // تحويل القوائم
        if (data['schedules'] != null) {
          grades.assignAll(List<String>.from(data['schedules']));
        }
        
        if (data['subjectsTaught'] != null) {
          subjects.assignAll(List<String>.from(data['subjectsTaught']));
        }
        
      } else {
        Get.snackbar('Error', 'Failed to load profile data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Connection error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    box.erase();
    Get.snackbar('Logged Out', 'Successfully logged out');
    // Get.offAll(() => LoginScreen()); // توجه لشاشة تسجيل الدخول
  }
}