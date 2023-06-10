import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/api_keys.dart';
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
  TextEditingController quantityController = TextEditingController();

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

  Future<void> checkPayment({
    required GlobalKey<FormState> key,
    required int index,
    required List<Data> tabList,
  }) async {
    final isValid = key.currentState!.validate();
    if (!isValid) {
      return;
    } else if (!isPurposeFundSelected[0] && !isPurposeFundSelected[1] && !isPurposeFundSelected[2] && tabList[index].type! == 'Receipt') {
      Utils.validationCheck(isSuccess: false, message: AppStrings.pleaseSelectPurposeOfFund);
    } else {
      switch (tabList[index].type!) {
        case 'Receipt':
          await generatePDFApi(
            url: 'generateReceipePdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.address: addressController.text,
              ApiKeys.type: isPurposeFundSelected[0] ? 'Yes' : 'No',
              ApiKeys.type1: isPurposeFundSelected[1] ? 'Yes' : 'No',
              ApiKeys.type2: isPurposeFundSelected[2] ? 'Yes' : 'No',
              ApiKeys.cash: whichCashType[0],
              ApiKeys.chequeNumber: chequeNumberController.text,
              ApiKeys.chequeDate: chequeDateController.text,
              ApiKeys.bank: bankController.text,
              ApiKeys.branch: branchController.text,
              ApiKeys.accountNumber: accountNumberController.text,
              ApiKeys.panNumber: panNumberController.text,
            },
          );
          return;

        case 'Band Party':
          await generatePDFApi(
            url: 'generateBandPartyPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
            },
          );
          return;

        case 'Makan Bandhkam':
          await generatePDFApi(
            url: 'generateMakanBandhkamPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
            },
          );
          return;

        case 'Sarvar':
          await generatePDFApi(
            url: 'generateSarvarPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
            },
          );
          return;

        case 'Vahan Vyavastha':
          await generatePDFApi(
            url: 'generateVahanVyavsthaPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
            },
          );
          return;

        case 'Gau Dohan':
          await generatePDFApi(
            url: 'generateGauDohanPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.quantity: quantityController.text,
            },
          );
          return;

        case 'Niran':
          await generatePDFApi(
            url: 'generateNiranPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.quantity: quantityController.text,
            },
          );
          return;
      }
    }
  }

  Future<void> generatePDFApi({required String url, required Map<String, dynamic> params}) async {
    final response = await PaymentService().generatePDFApiService(
      apiUrl: url,
      params: params,
    );

    if (response?.code == '200') {
      await Share.share(response!.path!, subject: 'Share Receipt to person.');
      resetControllers();
    } else {}
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
    nameController.clear();
    addressController.clear();
    resetChequeControllers();
    quantityController.clear();
  }

  void disposeControllers() {
    amountController.dispose();
    nameController.dispose();
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
