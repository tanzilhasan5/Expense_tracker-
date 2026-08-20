import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../../../data/models/expense_model.dart';
import '../controllers/analytics_controller.dart';
import '../../home/controllers/home_controller.dart';

import 'dart:math';

class AnalyticsView extends GetView<AnalyticsController> {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: homeController.refreshData,
          color: AppColor.green,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Analytics',
                style: AppTextStyles.title26_600(color: AppColor.textColor),
              ),
              SizedBox(height: 16.h),

              // Time Range Tabs
              Container(
                height: 44.h,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFECEFF1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Obx(() => Row(
                      children: controller.timeFrames.map((frame) {
                        final isSelected = controller.selectedTimeFrame.value == frame;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => controller.changeTimeFrame(frame),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        )
                                      ]
                                    : null,
                              ),
                              child: Text(
                                frame,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColor.textColor
                                      : AppColor.secondarytextColor,
                                  fontSize: 13.sp,
                                  fontWeight:
                                      isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )),
              ),
              SizedBox(height: 20.h),

              // Summary cards row & charts reactively filtered by selected time frame
              Obx(() {
                final frame = controller.selectedTimeFrame.value;
                final allExpenses = homeController.expenses;

                final now = DateTime.now();
                DateTime cutoff;
                double daysCount = 30.0;

                if (frame == '7 Days') {
                  cutoff = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6));
                  daysCount = 7.0;
                } else if (frame == 'Year') {
                  cutoff = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 365));
                  daysCount = 365.0;
                } else {
                  // 'Month'
                  cutoff = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 30));
                  daysCount = 30.0;
                }

                final filteredExpenses = allExpenses.where((exp) {
                  return exp.date.isAfter(cutoff) || exp.date.isAtSameMomentAs(cutoff);
                }).toList();

                final totalSpent = filteredExpenses.fold(0.0, (sum, item) => sum + item.amount);
                final averageSpentPerDay = filteredExpenses.isEmpty ? 0.0 : totalSpent / daysCount;
                final transactionsCount = filteredExpenses.length;

                // Calculate Category Totals for filtered list
                final totals = {
                  'Shopping': 0.0,
                  'Bills': 0.0,
                  'Food': 0.0,
                  'Transport': 0.0,
                  'Others': 0.0,
                };
                for (var exp in filteredExpenses) {
                  if (totals.containsKey(exp.category)) {
                    totals[exp.category] = totals[exp.category]! + exp.amount;
                  } else {
                    totals['Others'] = totals['Others']! + exp.amount;
                  }
                }

                final shopping = totals['Shopping'] ?? 0.0;
                final bills = totals['Bills'] ?? 0.0;
                final food = totals['Food'] ?? 0.0;
                final transport = totals['Transport'] ?? 0.0;
                final others = totals['Others'] ?? 0.0;

                final List<double> chartValues = [shopping, bills, food, transport, others];
                final List<Color> chartColors = [
                  const Color(0xFF9C27B0),
                  const Color(0xFFE53935),
                  const Color(0xFFFF9800),
                  const Color(0xFF1E88E5),
                  const Color(0xFF757575),
                ];

                // Top Category Calculation
                String topCatName = 'None';
                String topCatEmoji = '📦';
                double maxAmt = 0.0;
                final emojiMap = {
                  'Shopping': '🛍️',
                  'Bills': '💡',
                  'Food': '🍽️',
                  'Transport': '🚌',
                  'Others': '📦',
                };

                totals.forEach((key, val) {
                  if (val > maxAmt) {
                    maxAmt = val;
                    topCatName = key;
                    topCatEmoji = emojiMap[key] ?? '📦';
                  }
                });

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Summary Cards
                    Row(
                      children: [
                        _buildSummaryCard(
                          'TOTAL',
                          '\$${totalSpent.toStringAsFixed(2)}',
                        ),
                        SizedBox(width: 12.w),
                        _buildSummaryCard(
                          'AVG/DAY',
                          '\$${averageSpentPerDay.toStringAsFixed(2)}',
                        ),
                        SizedBox(width: 12.w),
                        _buildSummaryCard(
                          'TXNS',
                          '$transactionsCount',
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Spending by Category card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Spending by Category',
                            style: AppTextStyles.title16_w700(color: AppColor.textColor),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              // Donut Chart
                              SizedBox(
                                width: 110.w,
                                height: 110.w,
                                child: CustomPaint(
                                  painter: DonutChartPainter(
                                    values: chartValues,
                                    colors: chartColors,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.w),
                              // Legend List
                              Expanded(
                                child: Column(
                                  children: [
                                    _buildLegendItem('Shopping', shopping, totalSpent, const Color(0xFF9C27B0)),
                                    SizedBox(height: 8.h),
                                    _buildLegendItem('Bills', bills, totalSpent, const Color(0xFFE53935)),
                                    SizedBox(height: 8.h),
                                    _buildLegendItem('Food', food, totalSpent, const Color(0xFFFF9800)),
                                    SizedBox(height: 8.h),
                                    _buildLegendItem('Transport', transport, totalSpent, const Color(0xFF1E88E5)),
                                    SizedBox(height: 8.h),
                                    _buildLegendItem('Others', others, totalSpent, const Color(0xFF757575)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),

                          // Top Category Box
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3E5F5),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    topCatEmoji,
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'TOP CATEGORY',
                                      style: TextStyle(
                                        color: const Color(0xFF7B1FA2),
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      '$topCatName — \$${maxAmt.toStringAsFixed(2)}',
                                      style: AppTextStyles.title12_w600(
                                        color: const Color(0xFF4A148C),
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
                    SizedBox(height: 20.h),

                    // Spending Over Time card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Spending Over Time ($frame)',
                            style: AppTextStyles.title16_w700(color: AppColor.textColor),
                          ),
                          SizedBox(height: 24.h),
                          SizedBox(
                            height: 140.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: _buildDynamicBars(frame, filteredExpenses),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 80.h),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    ));
  }

  List<Widget> _buildDynamicBars(String frame, List<Expense> expenses) {
    final now = DateTime.now();

    if (frame == '7 Days') {
      final days = List.generate(7, (i) {
        final d = now.subtract(Duration(days: 6 - i));
        final dayExpenses = expenses.where((e) =>
            e.date.year == d.year && e.date.month == d.month && e.date.day == d.day);
        final sum = dayExpenses.fold(0.0, (s, e) => s + e.amount);
        final dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][d.weekday - 1];
        return {'label': dayName, 'sum': sum};
      });

      double maxVal = days.fold(0.0, (m, e) => (e['sum'] as double) > m ? (e['sum'] as double) : m);
      if (maxVal == 0) maxVal = 1.0;

      return days.map((e) {
        final amt = e['sum'] as double;
        final barHeight = (amt / maxVal) * 80.h;
        return _buildBarItem(e['label'] as String, max(barHeight, 4.h), '\$${amt.toStringAsFixed(0)}');
      }).toList();
    } else if (frame == 'Year') {
      final months = [1, 3, 5, 7, 9, 11];
      final monthLabels = ['Jan', 'Mar', 'May', 'Jul', 'Sep', 'Nov'];
      final list = List.generate(6, (i) {
        final m = months[i];
        final mExpenses = expenses.where((e) => e.date.year == now.year && e.date.month == m);
        final sum = mExpenses.fold(0.0, (s, e) => s + e.amount);
        return {'label': monthLabels[i], 'sum': sum};
      });

      double maxVal = list.fold(0.0, (m, e) => (e['sum'] as double) > m ? (e['sum'] as double) : m);
      if (maxVal == 0) maxVal = 1.0;

      return list.map((e) {
        final amt = e['sum'] as double;
        final barHeight = (amt / maxVal) * 80.h;
        return _buildBarItem(e['label'] as String, max(barHeight, 4.h), '\$${amt.toStringAsFixed(0)}');
      }).toList();
    } else {
      // Default: 'Month' (W1, W2, W3, W4)
      final weeks = List.generate(4, (i) {
        final startDay = now.subtract(Duration(days: 28 - (i * 7)));
        final endDay = startDay.add(const Duration(days: 7));
        final wExpenses = expenses.where((e) => e.date.isAfter(startDay) && e.date.isBefore(endDay));
        final sum = wExpenses.fold(0.0, (s, e) => s + e.amount);
        return {'label': 'W${i + 1}', 'sum': sum};
      });

      double maxVal = weeks.fold(0.0, (m, e) => (e['sum'] as double) > m ? (e['sum'] as double) : m);
      if (maxVal == 0) maxVal = 1.0;

      return weeks.map((e) {
        final amt = e['sum'] as double;
        final barHeight = (amt / maxVal) * 80.h;
        return _buildBarItem(e['label'] as String, max(barHeight, 4.h), '\$${amt.toStringAsFixed(0)}');
      }).toList();
    }
  }

  Widget _buildSummaryCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.01),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColor.secondarytextColor,
                fontSize: 9.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              value,
              style: AppTextStyles.title14_w500(color: AppColor.textColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String category, double amount, double total, Color color) {
    final double percent = total > 0 ? (amount / total) * 100 : 0.0;
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            category,
            style: AppTextStyles.title12_w500(color: AppColor.textColor),
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(0)}',
          style: AppTextStyles.title12_w600(color: AppColor.textColor),
        ),
        SizedBox(width: 8.w),
        Text(
          '${percent.toStringAsFixed(0)}%',
          style: AppTextStyles.title12_w400(color: AppColor.secondarytextColor),
        ),
      ],
    );
  }

  Widget _buildBarItem(String label, double height, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 8.sp, color: AppColor.secondarytextColor),
        ),
        SizedBox(height: 4.h),
        Container(
          width: 16.w,
          height: height,
          decoration: BoxDecoration(
            color: AppColor.green,
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: AppTextStyles.title10_w500(color: AppColor.secondarytextColor),
        ),
      ],
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;

  DonutChartPainter({required this.values, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final double total = values.fold(0.0, (sum, val) => sum + val);
    if (total == 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    final strokeWidth = radius * 0.35; // thickness of donut

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    double startAngle = -pi / 2; // Start from top center

    for (int i = 0; i < values.length; i++) {
      if (values[i] == 0) continue;
      final sweepAngle = (values[i] / total) * 2 * pi;
      paint.color = colors[i];

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweepAngle - 0.04, // slight spacing between arcs
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
