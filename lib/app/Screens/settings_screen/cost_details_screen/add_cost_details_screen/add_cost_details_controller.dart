import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Constants/app_utils.dart';
import 'package:krishna_gaushala/app/Constants/app_validators.dart';
import 'package:krishna_gaushala/app/Network/services/settings_service/settings_service.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/cost_details_controller.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/cost_details_model/get_spends_model.dart' as GetSpends;

class AddCostDetailsController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController titleOfExpenditureController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxList<bool> whichCashType = RxList.generate(2, (index) => index == 0 ? true : false);
  TextEditingController chequeNumberController = TextEditingController();
  TextEditingController chequeDateController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  GetSpends.Data? editableData = GetSpends.Data();

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments['isEdit'] == true) {
      editableData = Get.arguments['editableData'];
      if (editableData != null) {
        amountController.text = editableData?.amount ?? '';
        titleOfExpenditureController.text = editableData?.spendTo ?? '';
        noteController.text = editableData?.notes ?? '';
      }
    }
  }

  ///validate amount
  String? validateAmount(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterAmount.tr;
    }
    return null;
  }

  ///validate Title of Expenditure
  String? validateTitleOfExpenditure(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterTitle.tr;
    }
    return null;
  }

  ///validate note
  String? validateNote(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterNote.tr;
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
    if (!AppValidators.phoneNumberValidator.hasMatch(value)) {
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

  ///validate cheque date
  String? validateChequeDate(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterChequeDate.tr;
    }
    return null;
  }

  ///validate bank
  String? validateBank(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterBank.tr;
    }
    return null;
  }

  ///validate branch
  String? validateBranch(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterBranch.tr;
    }
    return null;
  }

  ///validate account number
  String? validateAccountNumber(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterAccountNumber.tr;
    }
    return null;
  }

  ///validate pan number
  String? validatePANNumber(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterPanNumber.tr;
    }
    return null;
  }

  ///validate quantity
  String? validateQuantity(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterQuantity.tr;
    }
    return null;
  }

  Future<void> checkAddCostDetails({
    required GlobalKey<FormState> key,
  }) async {
    final isValid = key.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final response = await SettingsService().spendAmountApiService(
        amount: amountController.text,
        spendTo: titleOfExpenditureController.text,
        notes: noteController.text,
      );

      if (response?.code == '200') {
        Get.back(closeOverlays: true);
        Utils.validationCheck(message: response?.msg);
        await Get.find<CostDetailsController>().checkCostDetails();
      }
    }
  }

  Future<void> checkEditCostDetails({
    required GlobalKey<FormState> key,
    required String spendId,
  }) async {
    final isValid = key.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final response = await SettingsService().editSpendAmountApiService(
        amount: amountController.text,
        spendTo: titleOfExpenditureController.text,
        notes: noteController.text,
        spendId: spendId,
      );

      if (response?.code == '200') {
        Get.back(closeOverlays: true);
        Utils.validationCheck(message: response?.msg);
        await Get.find<CostDetailsController>().checkCostDetails();
      }
    }
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void resetChequeControllers() {
    chequeDateController.clear();
    chequeNumberController.clear();
    bankController.clear();
    branchController.clear();
    accountNumberController.clear();
    panNumberController.clear();
  }

  void resetControllers() {
    amountController.clear();
    titleOfExpenditureController.clear();
    noteController.clear();
    addressController.clear();
    resetChequeControllers();
    quantityController.clear();
  }

  void disposeControllers() {
    amountController.dispose();
    titleOfExpenditureController.dispose();
    noteController.dispose();
    addressController.dispose();
    chequeDateController.dispose();
    chequeNumberController.dispose();
    bankController.dispose();
    branchController.dispose();
    accountNumberController.dispose();
    panNumberController.dispose();
    quantityController.dispose();
  }
}
