import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Network/services/settings_service/settings_service.dart';

class AddCostDetailsController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController titleOfExpenditureController = TextEditingController();
  TextEditingController noteController = TextEditingController();

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
        Get.back(closeOverlays:  true);
      }
    }
  }
}
