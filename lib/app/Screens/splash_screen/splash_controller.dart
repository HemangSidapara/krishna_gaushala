import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_constance.dart';
import 'package:krishna_gaushala/app/Constants/get_storage.dart';
import 'package:krishna_gaushala/app/Routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        getData(AppConstance.isLoggedIn) == true ? Get.offAllNamed(Routes.dashboard) : Get.offAllNamed(Routes.login);
      },
    );
  }
}
