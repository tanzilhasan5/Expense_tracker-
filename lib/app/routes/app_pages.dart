import 'package:get/get.dart';

import '../modules/Add_expenses/bindings/add_expenses_binding.dart';
import '../modules/Add_expenses/views/add_expenses_view.dart';
import '../modules/Analytics/bindings/analytics_binding.dart';
import '../modules/Analytics/views/analytics_view.dart';
import '../modules/Edit_Profile/bindings/edit_profile_binding.dart';
import '../modules/Edit_Profile/views/edit_profile_view.dart';
import '../modules/Expenses/bindings/expenses_binding.dart';
import '../modules/Expenses/views/expenses_view.dart';
import '../modules/Profile/bindings/profile_binding.dart';
import '../modules/Profile/views/profile_view.dart';
import '../modules/auth/Forget_password/bindings/forget_password_binding.dart';
import '../modules/auth/Forget_password/views/forget_password_view.dart';
import '../modules/auth/Login/bindings/login_binding.dart';
import '../modules/auth/Login/views/login_view.dart';
import '../modules/auth/Reset_password/bindings/reset_password_binding.dart';
import '../modules/auth/Reset_password/views/reset_password_view.dart';
import '../modules/auth/Signup/bindings/signup_binding.dart';
import '../modules/auth/Signup/views/signup_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/mainnavber/bindings/mainnavber_binding.dart';
import '../modules/mainnavber/views/mainnavber_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.EXPENSES,
      page: () => const ExpensesView(),
      binding: ExpensesBinding(),
      children: [
        GetPage(
          name: _Paths.EXPENSES,
          page: () => const ExpensesView(),
          binding: ExpensesBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.ADD_EXPENSES,
      page: () => const AddExpensesView(),
      binding: AddExpensesBinding(),
    ),
    GetPage(
      name: _Paths.ANALYTICS,
      page: () => const AnalyticsView(),
      binding: AnalyticsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAINNAVBER,
      page: () => const MainnavberView(),
      binding: MainnavberBinding(),
    ),
  ];
}
