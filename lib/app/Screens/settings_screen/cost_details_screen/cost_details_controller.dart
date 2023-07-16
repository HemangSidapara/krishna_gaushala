import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/api_keys.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Constants/app_validators.dart';
import 'package:krishna_gaushala/app/Network/services/settings_service/settings_service.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/generated_receipts_screen/generated_receipt_model/get_billing_model.dart';

class CostDetailsController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxList<bool> whichCashType = RxList.generate(2, (index) => index == 0 ? true : false);
  TextEditingController chequeNumberController = TextEditingController();
  TextEditingController voucherDateController = TextEditingController();
  TextEditingController expenseTypeController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  List<String> expenseTypeList = [
    AppStrings.niran,
    AppStrings.medicine,
    AppStrings.khor,
    AppStrings.majuri,
    AppStrings.driverSalary,
    AppStrings.bandParty,
    AppStrings.buildingMaterials,
    AppStrings.gowalPagar,
    AppStrings.diesel,
    AppStrings.other,
  ];
  RxInt whichExpenseType = (-1).obs;

  RxList<ExpenseList> defaultExpenseList = RxList();
  RxList<ExpenseList> expenseList = RxList();

  @override
  void onInit() async {
    super.onInit();
    await checkGeneratedReceipts();
  }

  ///validate amount
  String? validateAmount(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterAmount;
    } else if (!AppValidators.phoneNumberValidator.hasMatch(value)) {
      return AppStrings.amountIsNumericOnly;
    }
    return null;
  }

  ///validate name
  String? validateName(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterPersonName.tr;
    }
    return null;
  }

  ///validate phone number
  String? validatePhoneNumber(String value) {
    if (!AppValidators.phoneNumberValidator.hasMatch(value) && value.isNotEmpty) {
      return AppStrings.pleaseEnterValidPhoneNumber.tr;
    }
    return null;
  }

  ///validate address
  String? validateAddress(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterAddress.tr;
    }
    return null;
  }

  ///validate cheque number
  String? validateChequeNumber(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterChequeNumber.tr;
    }
    return null;
  }

  ///validate expense list
  String? validateExpenseList(int? value) {
    if (value == null) {
      return AppStrings.pleaseSelectExpenseType.tr;
    }
    return null;
  }

  ///validate voucher date
  String? validateVoucherDate(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterVoucherDate.tr;
    }
    return null;
  }

  ///validate expense type
  String? validateExpenseType(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterExpenseType.tr;
    }
    return null;
  }

  ///validate notes
  String? validateNotes(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterNote.tr;
    }
    return null;
  }

  Future<void> checkGeneratedReceipts() async {
    try {
      isLoading(true);
      final response = await SettingsService().getBillingApiService();

      if (response?.code == '200') {
        resetGeneratedReceipts();
        defaultExpenseList.addAll(response?.data?.expenseList ?? []);
        expenseList.addAll(response?.data?.expenseList ?? []);
      } else {
        resetGeneratedReceipts();
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> checkEditPDFApi({required String spendId}) async {
    final params = {
      ApiKeys.name: nameController.text,
      ApiKeys.phone: phoneController.text,
      ApiKeys.amount: amountController.text,
      ApiKeys.address: addressController.text,
      ApiKeys.type: whichExpenseType.value != -1 ? expenseTypeList[whichExpenseType.value] : '',
      ApiKeys.other: expenseTypeController.text,
      ApiKeys.notes: notesController.text,
      ApiKeys.cash: whichCashType[0] ? 'Yes' : 'No',
      ApiKeys.chequeNumber: chequeNumberController.text,
      ApiKeys.date: voucherDateController.text.replaceAll('/', '-'),
      ApiKeys.spendId: spendId,
    };

    final response = await SettingsService().editPdfApiService(
      apiUrl: 'updateExpensePdf',
      params: params,
    );

    if (response?.code == '200') {
      Get.back();
      await checkGeneratedReceipts();
    } else {}
  }

  Future<void> checkDeleteCostDetail({required String spendId}) async {
    final response = await SettingsService().deleteExpensePdfApiService(apiUrl: 'deleteExpensePdf', spendId: spendId);

    if (response?.code == '200') {
      Get.back();
      await checkGeneratedReceipts();
    } else {}
  }

  void resetGeneratedReceipts() {
    defaultExpenseList.clear();
    expenseList.clear();
  }

  void resetControllers() {
    amountController.clear();
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    expenseTypeController.clear();
    notesController.clear();
    chequeNumberController.clear();
    voucherDateController.clear();
  }

  @override
  void dispose() {
    amountController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    expenseTypeController.dispose();
    notesController.dispose();
    chequeNumberController.dispose();
    voucherDateController.dispose();
    super.dispose();
  }
}
