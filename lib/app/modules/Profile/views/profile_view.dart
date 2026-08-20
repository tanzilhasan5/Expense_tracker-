import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/profile_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  Future<void> _pickAndSaveImage(HomeController homeController) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 75,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        final base64Image = base64Encode(bytes);
        await homeController.updateUserPhoto(base64Image);
        Get.snackbar(
          'Success',
          'Profile picture updated successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  void _showEditNameDialog(BuildContext context, HomeController homeController) {
    final nameEditController = TextEditingController(text: homeController.userName.value);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit Full Name',
            style: AppTextStyles.title16_w700(color: AppColor.textColor),
          ),
          content: TextField(
            controller: nameEditController,
            style: AppTextStyles.title14_w500(color: AppColor.textColor),
            decoration: InputDecoration(
              hintText: 'Enter full name',
              filled: true,
              fillColor: const Color(0xFFF5F6F8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColor.secondarytextColor),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final newName = nameEditController.text.trim();
                if (newName.isNotEmpty) {
                  await homeController.updateUserName(newName);
                  if (context.mounted) Navigator.pop(context);
                  Get.snackbar(
                    'Success',
                    'Name updated successfully!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColor.green,
                    colorText: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: RefreshIndicator(
        onRefresh: homeController.refreshData,
        color: AppColor.green,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Purple Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 36.h),
                decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0C1B6E), Color(0xFF8E24AA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.r),
                    bottomRight: Radius.circular(32.r),
                  ),
                ),
                child: Column(
                  children: [
                    // Tappable Avatar with Camera Edit Badge
                    GestureDetector(
                      onTap: () => _pickAndSaveImage(homeController),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Obx(() {
                            final photoUrl = homeController.userPhotoUrl.value;
                            final name = homeController.userName.value;

                            if (photoUrl.isNotEmpty) {
                              try {
                                final bytes = base64Decode(
                                  photoUrl.contains(',') ? photoUrl.split(',').last : photoUrl,
                                );
                                return Container(
                                  width: 84.w,
                                  height: 84.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2.5),
                                    image: DecorationImage(
                                      image: MemoryImage(bytes),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              } catch (_) {}
                            }

                            return Container(
                              width: 84.w,
                              height: 84.w,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2.5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                name.isNotEmpty ? name[0].toUpperCase() : 'U',
                                style: AppTextStyles.title28_600(color: Colors.white),
                              ),
                            );
                          }),
                          // Camera Icon Badge
                          Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 16.w,
                              color: AppColor.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Name Row with Edit Pen Icon
                    GestureDetector(
                      onTap: () => _showEditNameDialog(context, homeController),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() => Text(
                                homeController.userName.value,
                                style: AppTextStyles.title20_w700(color: Colors.white),
                              )),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.edit_rounded,
                            color: Colors.white.withOpacity(0.8),
                            size: 16.w,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),

                    // Email
                    Obx(() => Text(
                          homeController.userEmail.value,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    // Stats row
                    Obx(() => Row(
                          children: [
                            _buildStatCard(
                              '\$${homeController.totalSpent.toStringAsFixed(2)}',
                              'TOTAL SPENT',
                            ),
                            SizedBox(width: 16.w),
                            _buildStatCard(
                              '${homeController.transactionsCount}',
                              'TRANSACTIONS',
                            ),
                          ],
                        )),
                    SizedBox(height: 24.h),

                    // Personal Info Card
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => _showEditNameDialog(context, homeController),
                            child: Obx(() => _buildInfoRow(
                                  'Full Name',
                                  homeController.userName.value,
                                  isEditable: true,
                                )),
                          ),
                          Divider(
                            height: 24.h,
                            thickness: 1.h,
                            color: const Color(0xFFF1F3F5),
                          ),
                          Obx(() => _buildInfoRow(
                                'Email',
                                homeController.userEmail.value,
                                isEditable: false,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Logout Button
                    CustomButton(
                      text: 'Logout',
                      backgroundColor: const Color(0xFFFFEBEE),
                      textColor: const Color(0xFFC62828),
                      icon: Icon(
                        Icons.logout_rounded,
                        color: const Color(0xFFC62828),
                        size: 18.w,
                      ),
                      onPressed: controller.logout,
                    ),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.title20_w700(color: AppColor.textColor),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                color: AppColor.secondarytextColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isEditable = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.title14_w500(color: AppColor.secondarytextColor),
        ),
        Row(
          children: [
            Text(
              value,
              style: AppTextStyles.title14_w500(color: AppColor.textColor),
            ),
            if (isEditable) ...[
              SizedBox(width: 6.w),
              Icon(
                Icons.edit_rounded,
                size: 14.w,
                color: AppColor.green,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
