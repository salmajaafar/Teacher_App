import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:parent_app/views/screens/verification.dart';
import 'package:parent_app/views/screens/confirmation_lottie.dart';
import 'package:parent_app/views/widget/error_bottomsheet.dart';

class AuthController extends GetxController {
  final box = GetStorage( );

  
  final TextEditingController Number = TextEditingController();
  final TextEditingController password = TextEditingController();

  
  var isLoading = false.obs;
  var isPasswordHidden = true.obs;

  
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  
  Future<void> login() async {
    
    if (Number.text.trim().isEmpty || password.text.trim().isEmpty) {
      ErrorBottomSheet.showErrorBottomSheet(
        title: "Alert",
        message: "Please fill in all fields to continue",
      );
      return;
    }

    isLoading.value = true;
    try {
     
      const String apiUrl = 'https://satiable-paternity-darkness.ngrok-free.dev/api/Auth/login'; 

      final response = await http.post(
        Uri.parse(apiUrl ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'accountNumber': Number.text.trim(),
          'password': password.text,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        
       
        await box.write('accessToken', responseData['accessToken']);
        await box.write('refreshToken', responseData['refreshToken']);
        await box.write('user', responseData['user']);

       
        Get.to(() => const ConfirmationLottie());
        await Future.delayed(const Duration(seconds: 4));
        Get.off(() => OtpPage(Number: Number.text.trim())); 
        
      } else {
       
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        ErrorBottomSheet.showErrorBottomSheet(
          title: "Login Failed",
          message: errorData['message'] ?? "Incorrect number or password, please try again",
        );
      }
    } on SocketException {
      
      ErrorBottomSheet.showErrorBottomSheet(
        title: "Connection Error",
        message: "No internet connection, please check your network and try again",
      );
    } on http.ClientException {
    
      ErrorBottomSheet.showErrorBottomSheet(
        title: "Network Error",
        message: "A problem occurred while connecting to the server, please try again later",
        );
    } catch (e) {
    
      ErrorBottomSheet.showErrorBottomSheet(
        title: "Unexpected Error",
        message: "Something went wrong: $e",
      );
    } finally {
    
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
   
    Number.dispose();
    password.dispose();
    super.onClose();
  }

  String? get accessToken => box.read('accessToken');
  Map<String, dynamic>? get user => box.read('user');
  String? get userRole => user?['role'];

  
  void logout() {
    box.erase();
    Get.snackbar('Logged Out', 'See you later');
    // Get.offAll(() => LoginScreen());
  }
}
