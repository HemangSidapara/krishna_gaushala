import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/generated_receipts_screen/generated_receipts_controller.dart';

class GeneratedReceiptsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GeneratedReceiptsController());
  }
}
