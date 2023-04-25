import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_binding.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_view.dart';
import 'package:krishna_gaushala/app/Screens/login_screen/login_binding.dart';
import 'package:krishna_gaushala/app/Screens/login_screen/login_view.dart';
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
  ];
}
