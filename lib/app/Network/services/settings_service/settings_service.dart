import 'dart:convert';

import 'package:krishna_gaushala/app/Constants/api_keys.dart';
import 'package:krishna_gaushala/app/Constants/api_urls.dart';
import 'package:krishna_gaushala/app/Constants/app_utils.dart';
import 'package:krishna_gaushala/app/Network/api_base_helper.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/add_cost_details_screen/add_cost_details_model/spend_amount_model.dart';

class SettingsService {
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
            print('spendAmount success :::: ${jsonDecode(res.response!.data)['msg'].length}');
            Utils.validationCheck(message: spendAmountModel.msg);
          } else {
            print('spendAmount error :::: ${jsonDecode(res.response!.data)['msg']}');
            Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
          }
        } else {
          print('spendAmount error :::: ${jsonDecode(res.response!.data)['msg']}');
          Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
        }
      },
    );
    return spendAmountModelFromJson(response.response.toString());
  }
}
