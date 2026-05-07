import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_app/views/screens/confirmation_lottie.dart';
import 'package:parent_app/views/widget/error_bottomsheet.dart';

class AuthController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() {
    if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
      ErrorBottomSheet.showErrorBottomSheet(
        title: "Error",
        message: "Please fill all fields",
      );
      return;
    }

    isLoading.value = true;

    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      ErrorBottomSheet.showErrorBottomSheet(
        title: "Success",
        message: "Logged in successfully",
      );

      Get.to(() => const ConfirmationLottie());
    });
  }

  void forgotPassword() {
    ErrorBottomSheet.showErrorBottomSheet(
      title: "Forgot Password",
      message: "Redirecting to password reset screen...",
    );
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
