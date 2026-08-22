import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../controllers/expenses_controller.dart';
import '../../home/controllers/home_controller.dart';


class ExpensesView extends GetView<ExpensesController> {
  const ExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: homeController.refreshData,
          color: AppColor.green,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'All Expenses',
                style: AppTextStyles.title26_600(color: AppColor.textColor),
              ),
              SizedBox(height: 16.h),

              // Filter Chips
              SizedBox(
                height: 40.h,
                child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final catName = controller.categories[index];

                        String emoji = '';
                        switch (catName) {
                          case 'Food':
                            emoji = '🍽️ ';
                            break;
                          case 'Transport':
                            emoji = '🚌 ';
                            break;
                          case 'Shopping':
                            emoji = '🛍️ ';
                            break;
                          case 'Bills':
                            emoji = '💡 ';
                            break;
                          case 'Others':
                            emoji = '📦 ';
                            break;
                        }

                        return Obx(() {
                          final isSelected = controller.selectedCategory.value == catName;
                          return GestureDetector(
                            onTap: () => controller.changeCategory(catName),
                            child: Container(
                              margin: EdgeInsets.only(right: 8.w),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.green.withOpacity(0.08)
                                    : Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.green
                                      : const Color(0xFFE9ECEF),
                                  width: 1.2,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (emoji.isNotEmpty)
                                    Text(
                                      emoji,
                                      style: TextStyle(fontSize: 13.sp),
                                    ),
                                  Text(
                                    catName,
                                    style: AppTextStyles.title12_w600(
                                      color: isSelected
                                          ? AppColor.green
                                          : AppColor.textColor,
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
              SizedBox(height: 20.h),

              // Expenses List
              Expanded(
                child: Obx(() {
                  final filteredList = homeController.expenses.where((exp) {
                    if (controller.selectedCategory.value == 'All') return true;
                    return exp.category == controller.selectedCategory.value;
                  }).toList();

                  if (filteredList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 48.r,
                            color: AppColor.secondarytextColor.withOpacity(0.5),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'No transactions in this category.',
                            style: AppTextStyles.title14_w400(
                              color: AppColor.secondarytextColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredList.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1.h,
                          thickness: 1.h,
                          color: const Color(0xFFF1F3F5),
                        ),
                        itemBuilder: (context, index) {
                          final item = filteredList[index];
                          return Card(
                              color: Colors.blue.shade50,
                              child: _buildTransactionRow(item));
                        },
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildTransactionRow(dynamic item) {
    Color catColor = const Color(0xFF757575);
    String emoji = '📦';

    switch (item.category) {
      case 'Shopping':
        catColor = const Color(0xFF9C27B0);
        emoji = '🛍️';
        break;
      case 'Bills':
        catColor = const Color(0xFFE53935);
        emoji = '💡';
        break;
      case 'Food':
        catColor = const Color(0xFFFF9800);
        emoji = '🍽️';
        break;
      case 'Transport':
        catColor = const Color(0xFF1E88E5);
        emoji = '🚌';
        break;
      case 'Others':
        catColor = const Color(0xFF757575);
        emoji = '📦';
        break;
    }

    final formattedDate = DateFormat('MMM dd').format(item.date);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          // Emoji circle
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: Text(
              emoji,
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
          SizedBox(width: 12.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.category,
                  style: AppTextStyles.title14_w500(color: AppColor.textColor),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${item.note} · $formattedDate',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.title12_w400(
                    color: AppColor.secondarytextColor,
                  ),
                ),
              ],
            ),
          ),
          // Amount
          Text(
            '\$${item.amount.toStringAsFixed(2)}',
            style: AppTextStyles.title14_w500(color: AppColor.textColor),
          ),
        ],
      ),
    );
  }
}
