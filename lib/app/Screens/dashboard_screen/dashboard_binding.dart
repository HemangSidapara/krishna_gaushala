import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}
