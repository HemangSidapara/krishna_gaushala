import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Network/services/settings_service/settings_service.dart';

import 'generated_receipt_model/get_billing_model.dart';

class GeneratedReceiptsController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Data> invoicesList = RxList();

  @override
  void onInit() async {
    super.onInit();
    await checkGeneratedReceipts();
  }

  Future<void> checkGeneratedReceipts() async {
    try {
      isLoading(true);
      final response = await SettingsService().getBillingApiService();

      if (response?.code == '200') {
        invoicesList.value = response?.data ?? [];
      } else {
        invoicesList.value = [];
      }
    } finally {
      isLoading(false);
    }
  }
}
