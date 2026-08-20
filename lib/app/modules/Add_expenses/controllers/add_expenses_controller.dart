import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpensesController extends GetxController {
  late TextEditingController amountController;
  late TextEditingController noteController;

  final selectedCategory = 'Food'.obs;
  final selectedDate = DateTime.now().obs;

  final categories = const [
    {'name': 'Food', 'emoji': '🍽️', 'color': Color(0xFFFF9800)},
    {'name': 'Transport', 'emoji': '🚌', 'color': Color(0xFF1E88E5)},
    {'name': 'Shopping', 'emoji': '🛍️', 'color': Color(0xFF9C27B0)},
    {'name': 'Bills', 'emoji': '💡', 'color': Color(0xFFE53935)},
    {'name': 'Others', 'emoji': '📦', 'color': Color(0xFF757575)},
  ];

  @override
  void onInit() {
    super.onInit();
    amountController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void onClose() {
    amountController.dispose();
    noteController.dispose();
    super.onClose();
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  void changeDate(DateTime date) {
    selectedDate.value = date;
  }
}
