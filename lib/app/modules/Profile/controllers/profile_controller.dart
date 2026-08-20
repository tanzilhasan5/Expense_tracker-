import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
    Get.snackbar(
      'Logged Out',
      'You have been logged out successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.textColor.withOpacity(0.8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }
}
