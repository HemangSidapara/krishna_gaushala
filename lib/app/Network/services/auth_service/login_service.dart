import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:krishna_gaushala/app/Constants/api_keys.dart';
import 'package:krishna_gaushala/app/Constants/api_urls.dart';
import 'package:krishna_gaushala/app/Constants/app_constance.dart';
import 'package:krishna_gaushala/app/Constants/app_utils.dart';
import 'package:krishna_gaushala/app/Constants/get_storage.dart';
import 'package:krishna_gaushala/app/Network/api_base_helper.dart';
import 'package:krishna_gaushala/app/Screens/login_screen/login_models/login_model.dart';

class LoginService {
  Future<LoginModel?> loginApiService({
    required String username,
    required String password,
  }) async {
    var param = {
      ApiKeys.username: username,
      ApiKeys.password: password,
    };

    // var param = {
    //   ApiKeys.username: 'Admin',
    //   ApiKeys.password: 'admin@123',
    // };

    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.loginApi,
      showProgress: true,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        LoginModel loginModel = loginModelFromJson(res.response.toString());
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          if (loginModel.code == '200') {
            setData(AppConstance.isLoggedIn, true);
            if (kDebugMode) {
              print('login success :::: ${jsonDecode(res.response!.data)['msg']}');
            }
            Utils.validationCheck(message: loginModel.msg);
          } else {
            if (kDebugMode) {
              print('login error :::: ${jsonDecode(res.response!.data)['msg']}');
            }
            Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
          }
        } else {
          if (kDebugMode) {
            print('login error :::: ${jsonDecode(res.response!.data)['msg']}');
          }
          Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
        }
      },
      params: param,
    );
    return loginModelFromJson(response.response.toString());
  }
}
