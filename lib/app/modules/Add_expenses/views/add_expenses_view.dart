import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/add_expenses_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

class AddExpensesView extends GetView<AddExpensesController> {
  const AddExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the controller is registered
    final AddExpensesController controller = Get.put(AddExpensesController());
    final homeController = Get.find<HomeController>();

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28.r),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pull Handle
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),

              // Title & Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Expense',
                    style: AppTextStyles.title20_w700(color: AppColor.textColor),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close,
                      color: AppColor.secondarytextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Amount Section
              Text(
                'AMOUNT',
                style: TextStyle(
                  color: AppColor.secondarytextColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$ ',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.secondarytextColor,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller.amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.textColor,
                      ),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        hintStyle: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFB0BEC5),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.green, width: 2.h),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.green, width: 3.h),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Category Section
              Text(
                'CATEGORY',
                style: TextStyle(
                  color: AppColor.secondarytextColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 72.h,
                child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final cat = controller.categories[index];
                        final catName = cat['name'] as String;
                        final emoji = cat['emoji'] as String;
                        final color = cat['color'] as Color;

                        return Obx(() {
                          final isSelected = controller.selectedCategory.value == catName;
                          return GestureDetector(
                            onTap: () => controller.changeCategory(catName),
                            child: Container(
                              width: 68.w,
                              margin: EdgeInsets.only(right: 12.w),
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? color.withOpacity(0.08)
                                    : const Color(0xFFF5F6F8),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isSelected ? color : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    emoji,
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    catName,
                                    style: TextStyle(
                                      color: isSelected ? color : AppColor.secondarytextColor,
                                      fontSize: 10.sp,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),
              ),
              SizedBox(height: 24.h),

              // Date Section
              Text(
                'DATE',
                style: TextStyle(
                  color: AppColor.secondarytextColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate.value,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: AppColor.green,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    controller.changeDate(pickedDate);
                  }
                },
                child: Obx(() => Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F8),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('MM/dd/yyyy').format(controller.selectedDate.value),
                            style: AppTextStyles.title14_w500(color: AppColor.textColor),
                          ),
                          Icon(
                            Icons.calendar_today_rounded,
                            color: AppColor.secondarytextColor,
                            size: 18.w,
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(height: 24.h),

              // Note Section
              Text(
                'NOTE (OPTIONAL)',
                style: TextStyle(
                  color: AppColor.secondarytextColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: controller.noteController,
                style: AppTextStyles.title14_w500(color: AppColor.textColor),
                decoration: InputDecoration(
                  hintText: 'What was this for?',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFB0BEC5),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F6F8),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              // Save Expense Button
              CustomButton(
                text: 'Save Expense',
                onPressed: () {
                  final text = controller.amountController.text.trim();
                  if (text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please enter an amount',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withOpacity(0.8),
                      colorText: Colors.white,
                      margin: EdgeInsets.all(16.w),
                    );
                    return;
                  }

                  final amount = double.tryParse(text);
                  if (amount == null || amount <= 0) {
                    Get.snackbar(
                      'Error',
                      'Please enter a valid amount greater than zero',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withOpacity(0.8),
                      colorText: Colors.white,
                      margin: EdgeInsets.all(16.w),
                    );
                    return;
                  }

                  // Add expense
                  homeController.addExpense(
                    amount,
                    controller.selectedCategory.value,
                    controller.selectedDate.value,
                    controller.noteController.text.trim(),
                  );

                  // Close bottom sheet
                  Get.back();

                  // Success notification
                  Get.snackbar(
                    'Success',
                    'Expense added successfully!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColor.green.withOpacity(0.9),
                    colorText: Colors.white,
                    margin: EdgeInsets.all(16.w),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
