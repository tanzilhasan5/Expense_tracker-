import 'package:get/get.dart';

import '../controllers/add_expenses_controller.dart';

class AddExpensesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddExpensesController>(
      () => AddExpensesController(),
    );
  }
}
