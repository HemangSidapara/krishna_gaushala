import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Network/services/settings_service/settings_service.dart';

import 'generated_receipt_model/get_billing_model.dart';

class GeneratedReceiptsController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  RxList<Data> invoicesList = RxList();

  @override
  void onInit() async {
    super.onInit();
    await checkGeneratedReceipts();
  }

  ///validate amount
  String? validateAmount(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterAmount;
    }
    return null;
  }

  ///validate name
  String? validateName(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterPersonName;
    }
    return null;
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

  Future<void> checkEditReceipts({
    required GlobalKey<FormState> key,
    required String billId,
    required String type,
  }) async {
    final isValid = key.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final response = await SettingsService().editPdfApiService(
        amount: amountController.text,
        name: nameController.text,
        billId: billId,
        type: type,
      );

      if (response?.code == '200') {
        Get.back();
        await checkGeneratedReceipts();
      } else {}
    }
  }

  Future<void> checkDeleteReceipts({
    required String billId,
  }) async {
    final response = await SettingsService().deletePdfApiService(
      billId: billId,
    );

    if (response?.code == '200') {
      Get.back();
      await checkGeneratedReceipts();
    } else {}
  }
}
