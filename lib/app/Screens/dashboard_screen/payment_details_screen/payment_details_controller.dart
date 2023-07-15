import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/api_keys.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Constants/app_utils.dart';
import 'package:krishna_gaushala/app/Constants/app_validators.dart';
import 'package:krishna_gaushala/app/Network/services/dashboard_service/payment_service.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_controller.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_model/get_types_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentDetailsController extends GetxController {
  DashboardController dashboardController = Get.put(DashboardController());

  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
  TextEditingController voucherDateController = TextEditingController();
  TextEditingController expenseTypeController = TextEditingController();

  List<String> expenseList = [
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

  ///validate amount
  String? validateAmount(String value) {
    if (dashboardController.tabController.index != 1) {
      if (value.isEmpty) {
        return AppStrings.pleaseEnterAmount;
      } else if (!AppValidators.phoneNumberValidator.hasMatch(value)) {
        return AppStrings.amountIsNumericOnly;
      }
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

  Future<void> checkPayment({
    required GlobalKey<FormState> key,
    required int index,
    required List<Data> tabList,
  }) async {
    final isValid = key.currentState!.validate();
    if (!isValid) {
      return;
    } else if (!isPurposeFundSelected[0] && !isPurposeFundSelected[1] && !isPurposeFundSelected[2] && tabList[index].type! == 'Receipt') {
      Utils.validationCheck(isSuccess: false, message: AppStrings.pleaseSelectPurposeOfFund.tr);
    } else {
      switch (tabList[index].type!) {
        case 'Receipt':
          await generatePDFApi(
            url: 'generateReceipePdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.phone: phoneController.text,
              ApiKeys.address: addressController.text,
              ApiKeys.type: isPurposeFundSelected[0] ? 'Yes' : 'No',
              ApiKeys.type1: isPurposeFundSelected[1] ? 'Yes' : 'No',
              ApiKeys.type2: isPurposeFundSelected[2] ? 'Yes' : 'No',
              ApiKeys.cash: whichCashType[0] ? 'Yes' : 'No',
              ApiKeys.chequeNumber: chequeNumberController.text,
              ApiKeys.chequeDate: chequeDateController.text,
              ApiKeys.bank: bankController.text,
              ApiKeys.branch: branchController.text,
              ApiKeys.accountNumber: accountNumberController.text,
              ApiKeys.panNumber: panNumberController.text,
            },
          );
          return;

        case 'Niran':
          await generatePDFApi(
            url: 'generateNiranPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.phone: phoneController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.quantity: quantityController.text,
              ApiKeys.address: addressController.text,
            },
          );
          return;

        case 'Gau Dohan':
          await generatePDFApi(
            url: 'generateGauDohanPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.phone: phoneController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.address: addressController.text,
            },
          );
          return;

        case 'Vahan Vyavastha':
          await generatePDFApi(
            url: 'generateVahanVyavsthaPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.phone: phoneController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.address: addressController.text,
            },
          );
          return;

        case 'Makan Bandhkam':
          await generatePDFApi(
            url: 'generateMakanBandhkamPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.phone: phoneController.text,
              ApiKeys.address: addressController.text,
            },
          );
          return;

        case 'Band Party':
          await generatePDFApi(
            url: 'generateBandPartyPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.phone: phoneController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.address: addressController.text,
            },
          );
          return;

        case 'Sarvar':
          await generatePDFApi(
            url: 'generateSarvarPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.phone: phoneController.text,
              ApiKeys.amount: amountController.text,
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
      if (phoneController.text.trim() != '') {
        String contactNo = phoneController.text;
        String waUrl = 'whatsapp://send?phone=+91$contactNo&text=Your receipt is here👇\n${response!.path!}';
        String waWebUrl = 'https://wa.me/+91$contactNo?text=Your receipt is here👇\n${response.path!}';
        try {
          await launchUrl(
            Uri.parse(waUrl),
            mode: LaunchMode.externalApplication,
          );
        } on PlatformException catch (e) {
          if (kDebugMode) {
            print('onError sharePdf to WA :: ${e.code}');
          }
          if (e.code == 'ACTIVITY_NOT_FOUND') {
            await launchUrl(
              Uri.parse(waWebUrl),
              mode: LaunchMode.externalApplication,
            );
          }
        }
      } else {
        await Share.share(response!.path!, subject: 'Share Receipt to person.');
      }
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
    phoneController.clear();
    addressController.clear();
    resetChequeControllers();
    quantityController.clear();
  }

  void disposeControllers() {
    amountController.dispose();
    nameController.dispose();
    phoneController.dispose();
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
