import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Network/services/dashboard_service/payment_service.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_model/get_types_model.dart';
import 'package:share_plus/share_plus.dart';

class PaymentDetailsController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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

  Future<void> checkPayment({
    required GlobalKey<FormState> key,
    required int index,
    required List<Data> tabList,
  }) async {
    final isValid = key.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final response = await PaymentService().generatePDFApiService(
        name: nameController.text,
        amount: amountController.text,
        type: tabList[index].type!,
      );

      if (response?.code == '200') {
        await Share.share(response!.path!, subject: 'Share Receipt to person.');
        amountController.clear();
        nameController.clear();
      } else {}
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
