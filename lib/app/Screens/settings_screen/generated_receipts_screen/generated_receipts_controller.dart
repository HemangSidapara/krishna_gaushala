import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/api_keys.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Network/services/settings_service/settings_service.dart';

import 'generated_receipt_model/get_billing_model.dart';

class GeneratedReceiptsController extends GetxController {
  RxBool isLoading = false.obs;

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

  RxList<Receipt> receiptList = RxList();
  RxList<Niran> niranList = RxList();
  RxList<GauDohan> gauDohanList = RxList();
  RxList<VahanVyavastha> vahanVyavasthaList = RxList();
  RxList<Sarvar> sarvarList = RxList();
  RxList<MakanBandhkam> makanBandhkamList = RxList();
  RxList<BandParty> bandPartyList = RxList();

  @override
  void onInit() async {
    super.onInit();
    await checkGeneratedReceipts();
  }

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

  Future<void> checkGeneratedReceipts() async {
    try {
      isLoading(true);
      final response = await SettingsService().getBillingApiService();

      if (response?.code == '200') {
        receiptList.value = response?.data?.receipt ?? [];
        niranList.value = response?.data?.niran ?? [];
        gauDohanList.value = response?.data?.gauDohan ?? [];
        vahanVyavasthaList.value = response?.data?.vahanVyavastha ?? [];
        sarvarList.value = response?.data?.sarvar ?? [];
        makanBandhkamList.value = response?.data?.makanBandhkam ?? [];
        bandPartyList.value = response?.data?.bandParty ?? [];
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
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
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
              ApiKeys.billId: billId,
            },
          );
          return;
        case 'Niran':
          await editPDFApi(
            url: 'updateNiranPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.quantity: quantityController.text,
              ApiKeys.billId: billId,
            },
          );
          return;
        case 'Gau Dohan':
          await editPDFApi(
            url: 'updateGauDohanPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.quantity: quantityController.text,
              ApiKeys.billId: billId,
            },
          );
          return;
        case 'Vahan Vyavastha':
          await editPDFApi(
            url: 'updateVahanVyavsthaPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.billId: billId,
            },
          );
          return;
        case 'Sarvar':
          await editPDFApi(
            url: 'updateSarvarPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.billId: billId,
            },
          );
          return;
        case 'Makan Bandhkam':
          await editPDFApi(
            url: 'updateMakanBandhkamPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.billId: billId,
            },
          );
          return;
        case 'Band Party':
          await editPDFApi(
            url: 'updateBandPartyPdf',
            params: {
              ApiKeys.name: nameController.text,
              ApiKeys.amount: amountController.text,
              ApiKeys.billId: billId,
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
    receiptList.clear();
    niranList.clear();
    gauDohanList.clear();
    vahanVyavasthaList.clear();
    sarvarList.clear();
    makanBandhkamList.clear();
    bandPartyList.clear();
  }

  void resetControllers() {
    amountController.clear();
    nameController.clear();
    addressController.clear();
    resetControllers();
    quantityController.clear();
  }

  void resetChequeControllers() {
    chequeNumberController.clear();
    chequeDateController.clear();
    bankController.clear();
    branchController.clear();
    accountNumberController.clear();
    panNumberController.clear();
  }
}
