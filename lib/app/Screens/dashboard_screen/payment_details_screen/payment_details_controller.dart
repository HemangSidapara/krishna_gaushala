import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Constants/app_utils.dart';
import 'package:krishna_gaushala/app/Network/services/dashboard_service/payment_service.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_model/get_types_model.dart';
import 'package:share_plus/share_plus.dart';

class PaymentDetailsController extends GetxController {
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

  Future<void> checkPayment({
    required GlobalKey<FormState> key,
    required int index,
    required List<Data> tabList,
  }) async {
    final isValid = key.currentState!.validate();
    if (!isValid) {
      return;
    } else if (!isPurposeFundSelected[0] && !isPurposeFundSelected[1] && !isPurposeFundSelected[2]) {
      Utils.validationCheck(isSuccess: false, message: AppStrings.pleaseSelectPurposeOfFund);
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
