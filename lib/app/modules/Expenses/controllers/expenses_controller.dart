import 'package:get/get.dart';

class ExpensesController extends GetxController {
  final selectedCategory = 'All'.obs;

  final categories = const ['All', 'Food', 'Transport', 'Shopping', 'Bills', 'Others'];

  void changeCategory(String category) {
    selectedCategory.value = category;
  }
}
