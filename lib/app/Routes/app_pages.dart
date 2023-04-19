import 'package:get/get.dart';
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
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 2000),
    ),
  ];
}
