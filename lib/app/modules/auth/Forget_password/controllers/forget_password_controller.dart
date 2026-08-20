import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/colors.dart';

class ForgetPasswordController extends GetxController {
  late TextEditingController emailController;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void sendResetLink() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Validation Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((_) {
      isLoading.value = false;
      Get.back(); // Go back to Login View
      Get.defaultDialog(
        title: 'Email Sent',
        middleText: 'Password reset link has been sent to $email. Please check your inbox.',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        buttonColor: AppColor.green,
        onConfirm: () => Get.back(),
      );
    }).catchError((error) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        error.toString().split(']').last.trim(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    });
  }
}
