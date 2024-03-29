import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:krishna_gaushala/app/Constants/api_urls.dart';
import 'package:krishna_gaushala/app/Constants/app_utils.dart';
import 'package:krishna_gaushala/app/Network/api_base_helper.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_model/get_types_model.dart';

class DashboardService{
  Future<GetTypesModel?> getTypesApiService() async {
    var response = await ApiBaseHelper().getHTTP(
      ApiUrls.getTypesApi,
      showProgress: false,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        GetTypesModel getTypesModel = getTypesModelFromJson(res.response.toString());
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          if (getTypesModel.code == '200') {
            if (kDebugMode) {
              print('getTypes success :::: ${jsonDecode(res.response!.data)['msg'].length}');
            }
          } else {
            if (kDebugMode) {
              print('getTypes error :::: ${jsonDecode(res.response!.data)['msg']}');
            }
          }
        } else {
          if (kDebugMode) {
            print('getTypes error :::: ${jsonDecode(res.response!.data)['msg']}');
          }
        }
      },
    );
    return getTypesModelFromJson(response.response.toString());
  }
}