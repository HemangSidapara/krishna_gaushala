import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/settings_controller.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
  }
}
