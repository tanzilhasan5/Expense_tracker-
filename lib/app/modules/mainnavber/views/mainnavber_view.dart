import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../controllers/mainnavber_controller.dart';
import '../../home/views/home_view.dart';
import '../../Expenses/views/expenses_view.dart';
import '../../Analytics/views/analytics_view.dart';
import '../../Profile/views/profile_view.dart';
import '../../Add_expenses/views/add_expenses_view.dart';

class MainnavberView extends GetView<MainnavberController> {
  const MainnavberView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeView(),
      const ExpensesView(),
      const AnalyticsView(),
      const ProfileView(),
    ];

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: pages,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            const AddExpensesView(),
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
          );
        },
        backgroundColor: AppColor.green,
        shape: const CircleBorder(),
        elevation: 4,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 6.0,
              color: Colors.white,
              elevation: 0,
              padding: EdgeInsets.zero,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabItem(
                    index: 0,
                    icon: Icons.home_filled,
                    label: 'Home',
                  ),
                  _buildTabItem(
                    index: 1,
                    icon: Icons.list_alt_rounded,
                    label: 'Expenses',
                  ),
                  const SizedBox(width: 48), // Spacer for center FAB
                  _buildTabItem(
                    index: 2,
                    icon: Icons.analytics_outlined,
                    label: 'Analytics',
                  ),
                  _buildTabItem(
                    index: 3,
                    icon: Icons.person_outline_rounded,
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildTabItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = controller.currentIndex.value == index;
    final color = isSelected ? AppColor.green : AppColor.secondarytextColor;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.currentIndex.value = index,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
