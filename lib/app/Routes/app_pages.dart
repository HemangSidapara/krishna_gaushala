import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_binding.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_view.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/payment_details_screen/payment_details_binding.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/payment_details_screen/payment_details_controller.dart';
import 'package:krishna_gaushala/app/Screens/login_screen/login_binding.dart';
import 'package:krishna_gaushala/app/Screens/login_screen/login_view.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/add_cost_details_screen/add_cost_details_binding.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/add_cost_details_screen/add_cost_details_view.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/cost_details_binding.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/cost_details_view.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/settings_binding.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/settings_view.dart';
import 'package:krishna_gaushala/app/Screens/splash_screen/splash_binding.dart';
import 'package:krishna_gaushala/app/Screens/splash_screen/splash_view.dart';

part 'app_routes.dart';

Duration transitionDuration = const Duration(milliseconds: 500);

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
      bindings: [
        PaymentDetailsBinding(),
      ],
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: Routes.costDetails,
      page: () => const CostDetailsView(),
      binding: CostDetailsBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: Routes.addCostDetails,
      page: () => const AddCostDetailsView(),
      binding: AddCostDetailsBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
  ];
}
