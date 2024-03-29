import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/api_keys.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Constants/app_validators.dart';
import 'package:krishna_gaushala/app/Network/services/settings_service/settings_service.dart';

import 'generated_receipt_model/get_billing_model.dart';

class GeneratedReceiptsController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

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

  RxList<Receipt> defaultReceiptList = RxList();
  RxList<Niran> defaultNiranList = RxList();
  RxList<GauDohan> defaultGauDohanList = RxList();
  RxList<VahanVyavastha> defaultVahanVyavasthaList = RxList();

  // RxList<Sarvar> defaultSarvarList = RxList();
  RxList<MakanBandhkam> defaultMakanBandhkamList = RxList();
  RxList<BandParty> defaultBandPartyList = RxList();

  RxList<Receipt> receiptList = RxList();
  RxList<Niran> niranList = RxList();
  RxList<GauDohan> gauDohanList = RxList();
  RxList<VahanVyavastha> vahanVyavasthaList = RxList();

  // RxList<Sarvar> sarvarList = RxList();
  RxList<MakanBandhkam> makanBandhkamList = RxList();
  RxList<BandParty> bandPartyList = RxList();

  @override
  void onInit() async {
    super.onInit();
    await checkGeneratedReceipts();
  }

  ///validate amount
  String? validateAmount(String value, String title) {
    if (value.isEmpty && title != AppStrings.receipt) {
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

  Future<void> checkGeneratedReceipts() async {
    try {
      isLoading(true);
      final response = await SettingsService().getBillingApiService();

      if (response?.code == '200') {
        resetGeneratedReceipts();
        defaultReceiptList.addAll(response?.data?.receipt ?? []);
        defaultNiranList.addAll(response?.data?.niran ?? []);
        defaultGauDohanList.addAll(response?.data?.gauDohan ?? []);
        defaultVahanVyavasthaList.addAll(response?.data?.vahanVyavastha ?? []);
        // defaultSarvarList.addAll(response?.data?.sarvar ?? []);
        defaultMakanBandhkamList.addAll(response?.data?.makanBandhkam ?? []);
        defaultBandPartyList.addAll(response?.data?.bandParty ?? []);
        receiptList.addAll(response?.data?.receipt ?? []);
        niranList.addAll(response?.data?.niran ?? []);
        gauDohanList.addAll(response?.data?.gauDohan ?? []);
        vahanVyavasthaList.addAll(response?.data?.vahanVyavastha ?? []);
        // sarvarList.addAll(response?.data?.sarvar ?? []);
        makanBandhkamList.addAll(response?.data?.makanBandhkam ?? []);
        bandPartyList.addAll(response?.data?.bandParty ?? []);
      } else {
        resetGeneratedReceipts();
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
      switch (type) {
        case 'Receipt':
          if (whichCashType[0]) {
            resetChequeControllers();
          }
          await editPDFApi(
            url: 'updateReceipePdf',
            params: {
              ApiKeys.name: nameController.text.trim(),
              ApiKeys.amount: amountController.text.trim(),
              ApiKeys.phone: phoneController.text.trim(),
              ApiKeys.address: addressController.text.trim(),
              ApiKeys.type: isPurposeFundSelected[0] ? 'Yes' : 'No',
              ApiKeys.type1: isPurposeFundSelected[1] ? 'Yes' : 'No',
              ApiKeys.type2: isPurposeFundSelected[2] ? 'Yes' : 'No',
              ApiKeys.cash: whichCashType[0] ? 'Yes' : 'No',
              ApiKeys.chequeNumber: chequeNumberController.text.trim(),
              ApiKeys.chequeDate: chequeDateController.text.trim(),
              ApiKeys.bank: bankController.text.trim(),
              ApiKeys.branch: branchController.text.trim(),
              ApiKeys.accountNumber: accountNumberController.text.trim(),
              ApiKeys.panNumber: panNumberController.text.trim(),
              ApiKeys.billId: billId,
            },
          );
          return;
        case 'Niran':
          await editPDFApi(
            url: 'updateNiranPdf',
            params: {
              ApiKeys.name: nameController.text.trim(),
              ApiKeys.phone: phoneController.text.trim(),
              ApiKeys.amount: amountController.text.isNumericOnly ? amountController.text.trim() : '0000',
              ApiKeys.quantity: quantityController.text.trim(),
              ApiKeys.billId: billId,
              ApiKeys.address: addressController.text.trim(),
            },
          );
          return;
        case 'Gau Dohan':
          await editPDFApi(
            url: 'updateGauDohanPdf',
            params: {
              ApiKeys.name: nameController.text.trim(),
              ApiKeys.phone: phoneController.text.trim(),
              ApiKeys.amount: amountController.text.trim(),
              ApiKeys.billId: billId,
              ApiKeys.address: addressController.text.trim(),
            },
          );
          return;
        case 'Vahan Vyavastha':
          await editPDFApi(
            url: 'updateVahanVyavsthaPdf',
            params: {
              ApiKeys.name: nameController.text.trim(),
              ApiKeys.phone: phoneController.text.trim(),
              ApiKeys.amount: amountController.text.trim(),
              ApiKeys.billId: billId,
              ApiKeys.address: addressController.text.trim(),
            },
          );
          return;
        case 'Sarvar':
          await editPDFApi(
            url: 'updateSarvarPdf',
            params: {
              ApiKeys.name: nameController.text.trim(),
              ApiKeys.phone: phoneController.text.trim(),
              ApiKeys.amount: amountController.text.trim(),
              ApiKeys.billId: billId,
              ApiKeys.address: addressController.text.trim(),
            },
          );
          return;
        case 'Makan Bandhkam':
          await editPDFApi(
            url: 'updateMakanBandhkamPdf',
            params: {
              ApiKeys.name: nameController.text.trim(),
              ApiKeys.phone: phoneController.text.trim(),
              ApiKeys.amount: amountController.text.trim(),
              ApiKeys.billId: billId,
              ApiKeys.address: addressController.text.trim(),
            },
          );
          return;
        case 'Band Party':
          await editPDFApi(
            url: 'updateBandPartyPdf',
            params: {
              ApiKeys.name: nameController.text.trim(),
              ApiKeys.phone: phoneController.text.trim(),
              ApiKeys.amount: amountController.text.trim(),
              ApiKeys.billId: billId,
              ApiKeys.address: addressController.text.trim(),
            },
          );
          return;
      }
    }
  }

  Future<void> editPDFApi({required String url, required Map<String, dynamic> params}) async {
    final response = await SettingsService().editPdfApiService(
      apiUrl: url,
      params: params,
    );

    if (response?.code == '200') {
      Get.back();
      await checkGeneratedReceipts();
    } else {}
  }

  Future<void> checkDeleteReceipts({
    required String billId,
    required String type,
  }) async {
    switch (type) {
      case 'Receipt':
        await deletePDFApi(
          url: 'deleteReceipePdf',
          billId: billId,
        );
        return;
      case 'Niran':
        await deletePDFApi(
          url: 'deleteNiranPdf',
          billId: billId,
        );
        return;
      case 'Gau Dohan':
        await deletePDFApi(
          url: 'deleteGauDohanPdf',
          billId: billId,
        );
        return;
      case 'Vahan Vyavastha':
        await deletePDFApi(
          url: 'deleteVahanVyavsthaPdf',
          billId: billId,
        );
        return;
      case 'Sarvar':
        await deletePDFApi(
          url: 'deleteSarvarPdf',
          billId: billId,
        );
        return;
      case 'Makan Bandhkam':
        await deletePDFApi(
          url: 'deleteMakanBandhkamPdf',
          billId: billId,
        );
        return;
      case 'Band Party':
        await deletePDFApi(
          url: 'deleteBandPartyPdf',
          billId: billId,
        );
        return;
    }
  }

  Future<void> deletePDFApi({required String url, required String billId}) async {
    final response = await SettingsService().deletePdfApiService(
      apiUrl: url,
      billId: billId,
    );

    if (response?.code == '200') {
      Get.back();
      await checkGeneratedReceipts();
    } else {}
  }

  void resetGeneratedReceipts() {
    defaultReceiptList.clear();
    defaultNiranList.clear();
    defaultGauDohanList.clear();
    defaultVahanVyavasthaList.clear();
    // defaultSarvarList.clear();
    defaultMakanBandhkamList.clear();
    defaultBandPartyList.clear();
    receiptList.clear();
    niranList.clear();
    gauDohanList.clear();
    vahanVyavasthaList.clear();
    // sarvarList.clear();
    makanBandhkamList.clear();
    bandPartyList.clear();
  }

  void resetControllers() {
    amountController.clear();
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    resetChequeControllers();
    quantityController.clear();
  }

  void resetChequeControllers() {
    chequeNumberController.clear();
    chequeDateController.clear();
    bankController.clear();
    branchController.clear();
    accountNumberController.clear();
  }

  @override
  void dispose() {
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
    super.dispose();
  }
}
