import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:krishna_gaushala/app/Constants/api_keys.dart';
import 'package:krishna_gaushala/app/Constants/api_urls.dart';
import 'package:krishna_gaushala/app/Constants/app_utils.dart';
import 'package:krishna_gaushala/app/Network/api_base_helper.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/add_cost_details_screen/add_cost_details_model/edit_spends_model.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/add_cost_details_screen/add_cost_details_model/spend_amount_model.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/cost_details_model/delete_spends_model.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/cost_details_model/get_spends_model.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/generated_receipts_screen/generated_receipt_model/delete_pdf_model.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/generated_receipts_screen/generated_receipt_model/edit_pdf_model.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/generated_receipts_screen/generated_receipt_model/get_billing_model.dart';

class SettingsService {
  Future<GetSpendsModel?> getSpendsApiService() async {
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.getSpendsApi,
      showProgress: false,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        GetSpendsModel getSpendsModel = getSpendsModelFromJson(res.response.toString());
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          if (getSpendsModel.code == '200') {
            print('getSpends success :::: ${jsonDecode(res.response!.data)['msg']}');
          } else {
            print('getSpends error :::: ${jsonDecode(res.response!.data)['msg']}');
            Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
          }
        } else {
          print('getSpends error :::: ${jsonDecode(res.response!.data)['msg']}');
          Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
        }
      },
    );
    return getSpendsModelFromJson(response.response.toString());
  }

  Future<SpendAmountModel?> spendAmountApiService({
    required String amount,
    required String spendTo,
    required String notes,
  }) async {
    final params = {
      ApiKeys.amount: amount,
      ApiKeys.spendTo: spendTo,
      ApiKeys.notes: notes,
    };
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.spendAmountApi,
      showProgress: true,
      params: params,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        SpendAmountModel spendAmountModel = spendAmountModelFromJson(res.response.toString());
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          if (spendAmountModel.code == '200') {
            if (kDebugMode) {
              print('spendAmount success :::: ${jsonDecode(res.response!.data)['msg'].length}');
            }
          } else {
            if (kDebugMode) {
              print('spendAmount error :::: ${jsonDecode(res.response!.data)['msg']}');
            }
            Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
          }
        } else {
          if (kDebugMode) {
            print('spendAmount error :::: ${jsonDecode(res.response!.data)['msg']}');
          }
          Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
        }
      },
    );
    return spendAmountModelFromJson(response.response.toString());
  }

  Future<GetBillingModel?> getBillingApiService() async {
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.getBillingApi,
      showProgress: false,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        GetBillingModel getBillingModel = getBillingModelFromJson(res.response.toString());
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          if (getBillingModel.code == '200') {
            print('getBilling success :::: ${jsonDecode(res.response!.data)['msg']}');
          } else {
            print('getBilling error :::: ${jsonDecode(res.response!.data)['msg']}');
            Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
          }
        } else {
          print('getBilling error :::: ${jsonDecode(res.response!.data)['msg']}');
          Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
        }
      },
    );
    return getBillingModelFromJson(response.response.toString());
  }

  Future<EditPdfModel?> editPdfApiService({
    required String apiUrl,
    required Map<String, dynamic> params,
  }) async {
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.generatePDFApi + apiUrl,
      showProgress: true,
      params: params,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        SpendAmountModel spendAmountModel = spendAmountModelFromJson(res.response.toString());
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          if (spendAmountModel.code == '200') {
            if (kDebugMode) {
              print('$apiUrl success :::: ${jsonDecode(res.response!.data)['msg']}');
            }
          } else {
            if (kDebugMode) {
              print('$apiUrl error :::: ${jsonDecode(res.response!.data)['msg']}');
            }
            Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
          }
        } else {
          if (kDebugMode) {
            print('$apiUrl error :::: ${jsonDecode(res.response!.data)['msg']}');
          }
          Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
        }
      },
    );
    return editPdfModelFromJson(response.response.toString());
  }

  Future<DeletePdfModel?> deletePdfApiService({
    required String apiUrl,
    required String billId,
  }) async {
    final params = {
      ApiKeys.billId: billId,
    };
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.generatePDFApi + apiUrl,
      showProgress: true,
      params: params,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        SpendAmountModel spendAmountModel = spendAmountModelFromJson(res.response.toString());
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          if (spendAmountModel.code == '200') {
            if (kDebugMode) {
              print('$apiUrl success :::: ${jsonDecode(res.response!.data)['msg']}');
            }
          } else {
            if (kDebugMode) {
              print('$apiUrl error :::: ${jsonDecode(res.response!.data)['msg']}');
            }
            Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
          }
        } else {
          if (kDebugMode) {
            print('$apiUrl error :::: ${jsonDecode(res.response!.data)['msg']}');
          }
          Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
        }
      },
    );
    return deletePdfModelFromJson(response.response.toString());
  }

  Future<DeletePdfModel?> deleteExpensePdfApiService({
    required String apiUrl,
    required String spendId,
  }) async {
    final params = {
      ApiKeys.spendId: spendId,
    };
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.generatePDFApi + apiUrl,
      showProgress: true,
      params: params,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        SpendAmountModel spendAmountModel = spendAmountModelFromJson(res.response.toString());
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          if (spendAmountModel.code == '200') {
            if (kDebugMode) {
              print('$apiUrl success :::: ${jsonDecode(res.response!.data)['msg']}');
            }
          } else {
            if (kDebugMode) {
              print('$apiUrl error :::: ${jsonDecode(res.response!.data)['msg']}');
            }
            Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
          }
        } else {
          if (kDebugMode) {
            print('$apiUrl error :::: ${jsonDecode(res.response!.data)['msg']}');
          }
          Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
        }
      },
    );
    return deletePdfModelFromJson(response.response.toString());
  }

  Future<EditSpendsModel?> editSpendAmountApiService({
    required String amount,
    required String spendTo,
    required String notes,
    required String spendId,
  }) async {
    final params = {
      ApiKeys.amount: amount,
      ApiKeys.spendTo: spendTo,
      ApiKeys.notes: notes,
      ApiKeys.spendId: spendId,
    };
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.editSpendApi,
      showProgress: true,
      params: params,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        SpendAmountModel spendAmountModel = spendAmountModelFromJson(res.response.toString());
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          if (spendAmountModel.code == '200') {
            if (kDebugMode) {
              print('editSpend success :::: ${jsonDecode(res.response!.data)['msg'].length}');
            }
          } else {
            if (kDebugMode) {
              print('editSpend error :::: ${jsonDecode(res.response!.data)['msg']}');
            }
            Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
          }
        } else {
          if (kDebugMode) {
            print('editSpend error :::: ${jsonDecode(res.response!.data)['msg']}');
          }
          Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
        }
      },
    );
    return editSpendsModelFromJson(response.response.toString());
  }

  Future<DeleteSpendsModel?> deleteSpendApiService({
    required String spendId,
  }) async {
    final params = {
      ApiKeys.spendId: spendId,
    };
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.deleteSpendApi,
      showProgress: true,
      params: params,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        SpendAmountModel spendAmountModel = spendAmountModelFromJson(res.response.toString());
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          if (spendAmountModel.code == '200') {
            if (kDebugMode) {
              print('deleteSpend success :::: ${jsonDecode(res.response!.data)['msg'].length}');
            }
          } else {
            if (kDebugMode) {
              print('deleteSpend error :::: ${jsonDecode(res.response!.data)['msg']}');
            }
            Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
          }
        } else {
          if (kDebugMode) {
            print('deleteSpend error :::: ${jsonDecode(res.response!.data)['msg']}');
          }
          Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
        }
      },
    );
    return deleteSpendsModelFromJson(response.response.toString());
  }
}
