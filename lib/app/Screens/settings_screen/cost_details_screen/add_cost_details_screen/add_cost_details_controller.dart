import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Constants/app_utils.dart';
import 'package:krishna_gaushala/app/Network/services/settings_service/settings_service.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/cost_details_controller.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/cost_details_model/get_spends_model.dart' as GetSpends;

class AddCostDetailsController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController titleOfExpenditureController = TextEditingController();
  TextEditingController noteController = TextEditingController();
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
      return AppStrings.pleaseEnterAmount;
    }
    return null;
  }

  ///validate Title of Expenditure
  String? validateTitleOfExpenditure(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterTitle;
    }
    return null;
  }

  ///validate note
  String? validateNote(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterNote;
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
    amountController.dispose();
    titleOfExpenditureController.dispose();
    noteController.dispose();
    super.dispose();
  }
}
