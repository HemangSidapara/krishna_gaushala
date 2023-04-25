import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Screens/login_screen/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
