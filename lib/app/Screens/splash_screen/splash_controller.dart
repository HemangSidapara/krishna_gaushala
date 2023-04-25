import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.toNamed(Routes.login);
      },
    );
  }
}
