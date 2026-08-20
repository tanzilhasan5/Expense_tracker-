import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

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
            // Green Profile Header
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
                  // Avatar
                  Obx(() => Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      homeController.userName.value.isNotEmpty
                          ? homeController.userName.value[0].toUpperCase()
                          : 'U',
                      style: AppTextStyles.title28_600(color: Colors.white),
                    ),
                  )),
                  SizedBox(height: 16.h),
                  // Name
                  Obx(() => Text(
                    homeController.userName.value,
                    style: AppTextStyles.title20_w700(color: Colors.white),
                  )),
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
                        Obx(() => _buildInfoRow('Full Name', homeController.userName.value)),
                        Divider(
                          height: 24.h,
                          thickness: 1.h,
                          color: const Color(0xFFF1F3F5),
                        ),
                        Obx(() => _buildInfoRow('Email', homeController.userEmail.value)),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Logout Button
                  CustomButton(
                    text: 'Logout',
                    backgroundColor: const Color(0xFFFFEBEE), // Light red
                    textColor: const Color(0xFFC62828), // Dark red
                    icon: Icon(
                      Icons.logout_rounded,
                      color: const Color(0xFFC62828),
                      size: 18.w,
                    ),
                    onPressed: controller.logout,
                  ),
                  SizedBox(height: 80.h), // Spacing for bottom navbar notch
                ],
              ),
            ),
          ],
        ),
      ),
    ));
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.title14_w500(color: AppColor.secondarytextColor),
        ),
        Text(
          value,
          style: AppTextStyles.title14_w500(color: AppColor.textColor),
        ),
      ],
    );
  }
}
