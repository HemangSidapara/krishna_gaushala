import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/add_cost_details_screen/add_cost_details_controller.dart';

class AddCostDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddCostDetailsController());
  }
}
