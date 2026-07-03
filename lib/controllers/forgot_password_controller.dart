import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_app/views/screens/confirmation_lottie.dart';
import 'package:parent_app/views/screens/verification.dart';
import 'package:parent_app/views/widget/error_bottomsheet.dart';

class ForgotPasswordController extends GetxController {
  final email = TextEditingController();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is String && arg.isNotEmpty) {
      email.text = arg;
    }
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }

  Future<void> sendResetLink() async {
    final value = email.text.trim();
    if (value.isEmpty) {
      ErrorBottomSheet.showErrorBottomSheet(
        title: 'Error',
        message: 'Please enter your email address',
      );
      return;
    }
    if (!GetUtils.isEmail(value)) {
      ErrorBottomSheet.showErrorBottomSheet(
        title: 'Error',
        message: 'Please enter a valid email address',
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    Get.to(() => const ConfirmationLottie());
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => OtpPage(Number: value));
  }
}
