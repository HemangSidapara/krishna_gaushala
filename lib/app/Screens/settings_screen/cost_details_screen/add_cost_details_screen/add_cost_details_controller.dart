import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';

class AddCostDetailsController extends GetxController{
  TextEditingController amountController = TextEditingController();

  ///validate amount
  String? validateAmount(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterAmount;
    }
    return null;
  }
}