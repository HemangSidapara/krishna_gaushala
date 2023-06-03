import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Network/services/settings_service/settings_service.dart';

import 'generated_receipt_model/get_billing_model.dart';

class GeneratedReceiptsController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxList<bool> isPurposeFundSelected = RxList.generate(3, (index) => false);
  RxList<bool> whichCashType = RxList.generate(2, (index) => index == 0 ? true : false);
  TextEditingController chequeNumberController = TextEditingController();
  TextEditingController chequeDateController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  RxList<Data> receiptList = RxList();
  RxList<Data> niranList = RxList();
  RxList<Data> gauDohanList = RxList();
  RxList<Data> vahanVyavasthaList = RxList();
  RxList<Data> sarvarList = RxList();
  RxList<Data> makanBandhkamList = RxList();
  RxList<Data> bandPartyList = RxList();

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

  ///validate address
  String? validateAddress(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterAddress;
    }
    return null;
  }

  ///validate cheque number
  String? validateChequeNumber(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterAddress;
    }
    return null;
  }

  ///validate cheque date
  String? validateChequeDate(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterChequeDate;
    }
    return null;
  }

  ///validate bank
  String? validateBank(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterBank;
    }
    return null;
  }

  ///validate branch
  String? validateBranch(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterBranch;
    }
    return null;
  }

  ///validate account number
  String? validateAccountNumber(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterAccountNumber;
    }
    return null;
  }

  ///validate pan number
  String? validatePANNumber(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterPanNumber;
    }
    return null;
  }

  ///validate quantity
  String? validateQuantity(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterQuantity;
    }
    return null;
  }

  Future<void> checkGeneratedReceipts() async {
    try {
      isLoading(true);
      final response = await SettingsService().getBillingApiService();

      if (response?.code == '200') {
        // invoicesList.value = response?.data ?? [];
      } else {
        // invoicesList.value = [];
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
