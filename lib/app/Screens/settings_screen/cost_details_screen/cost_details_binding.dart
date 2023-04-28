import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/cost_details_controller.dart';

class CostDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CostDetailsController());
  }
}
