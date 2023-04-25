import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Screens/splash_screen/splash_controller.dart';

class SplashBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(SplashController());
  }

}