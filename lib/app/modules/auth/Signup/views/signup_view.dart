import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/custom_scaffold.dart';
import '../../../../../utils/styles.dart';
import '../../../../widgets/custom_button.dart';
import '../controllers/signup_controller.dart';


class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScaffold(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App Brand Logo from Image
                  Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '\$',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Expense Tracker',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Form Card
                  Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Create Account',
                            style: AppTextStyles.title22_w600(color: AppColor.textColor),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Start managing your finances today',
                            style: AppTextStyles.title12_w400(
                              color: AppColor.secondarytextColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Full Name
                        Text(
                          'FULL NAME',
                          style: TextStyle(
                            color: AppColor.secondarytextColor,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: controller.nameController,
                          keyboardType: TextInputType.name,
                          style: AppTextStyles.title14_w500(color: AppColor.textColor),
                          decoration: _buildInputDecoration(
                            hintText: 'Enter your full name',
                            prefixIcon: Icons.person_outline_rounded,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Email Address
                        Text(
                          'EMAIL ADDRESS',
                          style: TextStyle(
                            color: AppColor.secondarytextColor,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: AppTextStyles.title14_w500(color: AppColor.textColor),
                          decoration: _buildInputDecoration(
                            hintText: 'Enter your email',
                            prefixIcon: Icons.email_outlined,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Password
                        Text(
                          'PASSWORD',
                          style: TextStyle(
                            color: AppColor.secondarytextColor,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Obx(() => TextField(
                              controller: controller.passwordController,
                              obscureText: !controller.isPasswordVisible.value,
                              style: AppTextStyles.title14_w500(color: AppColor.textColor),
                              decoration: _buildInputDecoration(
                                hintText: 'Enter your password',
                                prefixIcon: Icons.lock_outline_rounded,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    color: AppColor.secondarytextColor,
                                    size: 20.w,
                                  ),
                                  onPressed: () => controller.isPasswordVisible.value =
                                      !controller.isPasswordVisible.value,
                                ),
                              ),
                            )),
                        SizedBox(height: 16.h),

                        // Confirm Password
                        Text(
                          'CONFIRM PASSWORD',
                          style: TextStyle(
                            color: AppColor.secondarytextColor,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Obx(() => TextField(
                              controller: controller.confirmPasswordController,
                              obscureText: !controller.isConfirmPasswordVisible.value,
                              style: AppTextStyles.title14_w500(color: AppColor.textColor),
                              decoration: _buildInputDecoration(
                                hintText: 'Re-enter your password',
                                prefixIcon: Icons.lock_outline_rounded,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isConfirmPasswordVisible.value
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    color: AppColor.secondarytextColor,
                                    size: 20.w,
                                  ),
                                  onPressed: () => controller.isConfirmPasswordVisible.value =
                                      !controller.isConfirmPasswordVisible.value,
                                ),
                              ),
                            )),
                        SizedBox(height: 24.h),

                        // Submit Button
                        Obx(() => CustomButton(
                              text: controller.isLoading.value ? 'Creating Account...' : 'Sign Up',
                              onPressed: controller.isLoading.value ? null : controller.signup,
                            )),
                        SizedBox(height: 20.h),

                        // Footer Login Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: AppTextStyles.title12_w400(
                                color: AppColor.secondarytextColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Text(
                                'Login',
                                style: AppTextStyles.title12_w600(color: AppColor.green),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFFB0BEC5),
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: AppColor.secondarytextColor,
        size: 18.w,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF5F6F8),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColor.green, width: 1.5),
      ),
    );
  }
}
