import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/colors.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

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

    if (password.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Validation Error',
        'Password must be at least 6 characters long',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((credential) {
      isLoading.value = false;
      Get.offAllNamed(Routes.MAINNAVBER);
      Get.snackbar(
        'Welcome',
        'Logged in successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.green,
        colorText: Colors.white,
      );
    }).catchError((error) {
      isLoading.value = false;
      Get.snackbar(
        'Login Failed',
        error.toString().split(']').last.trim(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    });
  }
}
