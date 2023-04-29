import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Network/services/settings_service/settings_service.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/cost_details_model/get_spends_model.dart';

class CostDetailsController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Data> costDetailsList = RxList();

  @override
  void onInit() async {
    super.onInit();
    await checkCostDetails();
  }

  Future<void> checkCostDetails() async {
    try {
      isLoading(true);
      final response = await SettingsService().getSpendsApiService();

      if (response?.code == '200') {
        costDetailsList.value = response?.data ?? [];
      } else {
        costDetailsList.value = [];
      }
    } finally {
      isLoading(false);
    }
  }
}
