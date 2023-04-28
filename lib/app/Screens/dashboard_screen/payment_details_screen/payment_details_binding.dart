import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/payment_details_screen/payment_details_controller.dart';

class PaymentDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PaymentDetailsController());
  }
}
