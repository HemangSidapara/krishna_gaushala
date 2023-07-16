import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Screens/otp_screen/otp_controller.dart';

class OtpBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OtpController());
  }
}
