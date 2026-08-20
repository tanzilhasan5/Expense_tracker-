import 'package:get/get.dart';

import '../controllers/mainnavber_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../Expenses/controllers/expenses_controller.dart';
import '../../Analytics/controllers/analytics_controller.dart';
import '../../Profile/controllers/profile_controller.dart';
import '../../Add_expenses/controllers/add_expenses_controller.dart';

class MainnavberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainnavberController>(() => MainnavberController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ExpensesController>(() => ExpensesController());
    Get.lazyPut<AnalyticsController>(() => AnalyticsController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<AddExpensesController>(() => AddExpensesController());
  }
}
