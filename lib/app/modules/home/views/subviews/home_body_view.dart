import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/styles.dart';
import '../../../mainnavber/controllers/mainnavber_controller.dart';
import '../../controllers/home_controller.dart';


class HomeBodyView extends GetView<HomeController> {
  const HomeBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: controller.refreshData,
        color: AppColor.green,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info & Greeting
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                      'Hello, ${controller.userName.value} 👋',
                      style: AppTextStyles.title14_w500(
                        color: AppColor.secondarytextColor,
                      ),
                    )),
                    SizedBox(height: 2.h),
                    Text(
                      'Your Finances',
                      style: AppTextStyles.title26_600(
                        color: AppColor.textColor,
                      ),
                    ),
                  ],
                ),
                Obx(() => CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColor.green.withOpacity(0.1),
                  child: Text(
                    controller.userName.value.isNotEmpty
                        ? controller.userName.value[0].toUpperCase()
                        : 'U',
                    style: AppTextStyles.title14_w500(color: AppColor.green),
                  ),
                )),
              ],
            ),
            SizedBox(height: 16.h),

            // Green Header Card
            Obx(() => Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0C1B6E), Color(0xFF8E24AA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0C1B6E).withOpacity(0.25),
                        blurRadius: 15,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL SPENT',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '\$${controller.totalSpent.toStringAsFixed(2)}',
                        style: AppTextStyles.title40_w700(color: Colors.white),
                      ),
                      SizedBox(height: 16.h),
                      Divider(
                        color: Colors.white.withOpacity(0.15),
                        thickness: 1,
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'THIS MONTH',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  '\$${controller.spentThisMonth.toStringAsFixed(2)}',
                                  style: AppTextStyles.title18_w600(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 35.h,
                            width: 1,
                            color: Colors.white.withOpacity(0.15),
                          ),
                          SizedBox(width: 24.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TRANSACTIONS',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  '${controller.transactionsCount}',
                                  style: AppTextStyles.title18_w600(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 24.h),

            // By Category Section
            Text(
              'By Category',
              style: AppTextStyles.title18_w600(color: AppColor.textColor),
            ),
            SizedBox(height: 12.h),
            _buildCategoryList(),

            SizedBox(height: 24.h),

            // Recent Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent',
                  style: AppTextStyles.title18_w600(color: AppColor.textColor),
                ),
                GestureDetector(
                  onTap: () {
                    if (Get.isRegistered<MainnavberController>()) {
                      Get.find<MainnavberController>().currentIndex.value = 1;
                    } else {
                      controller.currentIndex.value = 1;
                    }
                  },
                  child: Text(
                    'See all',
                    style: AppTextStyles.title14_w500(color: AppColor.green),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Recent Transactions List
            Obx(() {
              final recentExpenses = controller.expenses.take(3).toList();
              if (recentExpenses.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Text(
                      'No recent transactions',
                      style: AppTextStyles.title14_w400(
                        color: AppColor.secondarytextColor,
                      ),
                    ),
                  ),
                );
              }
              return Container(
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
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(12.w),
                  itemCount: recentExpenses.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 16.h,
                    thickness: 1.h,
                    color: const Color(0xFFF1F3F5),
                  ),
                  itemBuilder: (context, index) {
                    final item = recentExpenses[index];
                    return _buildTransactionItem(item);
                  },
                ),
              );
            }),
            SizedBox(height: 80.h), // Extra space for navigation bar and FAB
          ],
        ),
      ),
    ),
  );
}

  Widget _buildCategoryList() {
    return Obx(() {
      final totals = controller.categoryTotals;
      final total = controller.totalSpent;

      final categories = [
        _CategoryInfo('Shopping', totals['Shopping'] ?? 0.0, total, '🛍️', const Color(0xFF9C27B0)),
        _CategoryInfo('Bills', totals['Bills'] ?? 0.0, total, '💡', const Color(0xFFE53935)),
        _CategoryInfo('Food', totals['Food'] ?? 0.0, total, '🍽️', const Color(0xFFFF9800)),
        _CategoryInfo('Transport', totals['Transport'] ?? 0.0, total, '🚌', const Color(0xFF1E88E5)),
        _CategoryInfo('Others', totals['Others'] ?? 0.0, total, '📦', const Color(0xFF757575)),
      ];

      return SizedBox(
        height: 120.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final cat = categories[index];
            final percent = total > 0 ? (cat.amount / total) : 0.0;
            return Container(
              width: 110.w,
              margin: EdgeInsets.only(
                right: index == categories.length - 1 ? 0 : 12.w,
              ),
              padding: EdgeInsets.all(12.w),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Emoji Circle
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: cat.color.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      cat.emoji,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cat.name,
                        style: AppTextStyles.title12_w500(
                          color: AppColor.secondarytextColor,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '\$${cat.amount.toStringAsFixed(2)}',
                        style: AppTextStyles.title14_w500(
                          color: AppColor.textColor,
                        ),
                      ),
                    ],
                  ),
                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: SizedBox(
                      height: 4.h,
                      child: LinearProgressIndicator(
                        value: percent,
                        backgroundColor: const Color(0xFFE9ECEF),
                        valueColor: AlwaysStoppedAnimation<Color>(cat.color),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildTransactionItem(dynamic item) {
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          // Emoji circle
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: catColor.withOpacity(0.08),
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

class _CategoryInfo {
  final String name;
  final double amount;
  final double total;
  final String emoji;
  final Color color;

  _CategoryInfo(this.name, this.amount, this.total, this.emoji, this.color);
}
