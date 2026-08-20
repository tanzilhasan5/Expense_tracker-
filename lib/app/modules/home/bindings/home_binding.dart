import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../Expenses/controllers/expenses_controller.dart';
import '../../Analytics/controllers/analytics_controller.dart';
import '../../Profile/controllers/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ExpensesController>(() => ExpensesController());
    Get.lazyPut<AnalyticsController>(() => AnalyticsController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
