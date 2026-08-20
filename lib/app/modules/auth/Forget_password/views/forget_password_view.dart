import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/custom_scaffold.dart';
import '../../../../../utils/styles.dart';
import '../../../../widgets/custom_button.dart';
import '../controllers/forget_password_controller.dart';


class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

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
                            'Forgot Password',
                            style: AppTextStyles.title22_w600(color: AppColor.textColor),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Enter your email to receive recovery instructions',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.title12_w400(
                              color: AppColor.secondarytextColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),

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
                        SizedBox(height: 24.h),

                        // Submit Button
                        Obx(() => CustomButton(
                              text: controller.isLoading.value ? 'Sending Link...' : 'Send Reset Link',
                              onPressed: controller.isLoading.value ? null : controller.sendResetLink,
                            )),
                        SizedBox(height: 20.h),

                        // Back to Login Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_rounded,
                              color: AppColor.green,
                              size: 14.w,
                            ),
                            SizedBox(width: 4.w),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Text(
                                'Back to Login',
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
