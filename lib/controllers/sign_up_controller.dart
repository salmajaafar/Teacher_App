import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_app/views/screens/logIn.dart';
import 'package:parent_app/views/widget/error_bottomsheet.dart';


class SignUpController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final studentNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  void createAccount() {

    
    if (passwordController.text != confirmPasswordController.text) {
      ErrorBottomSheet.showErrorBottomSheet(
        title: "Password Error",
        message: "Passwords do not match",
      );
      return;
    }

   
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        studentNumberController.text.isEmpty ||
        passwordController.text.isEmpty) {

      ErrorBottomSheet.showErrorBottomSheet(
        title: "Missing Data",
        message: "All fields are required",
      );
      return;
    }

    
    isLoading.value = true;

  
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      Get.snackbar(
        "Success",
        "Account Created Successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      
      Get.to(() => LoginScreen());
    });
  }

 
  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    studentNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();















  }
}