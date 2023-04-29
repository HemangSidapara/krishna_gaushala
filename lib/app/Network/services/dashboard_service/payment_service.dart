import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:krishna_gaushala/app/Constants/api_keys.dart';
import 'package:krishna_gaushala/app/Constants/api_urls.dart';
import 'package:krishna_gaushala/app/Constants/app_utils.dart';
import 'package:krishna_gaushala/app/Network/api_base_helper.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/payment_details_screen/payment_details_model/generate_pdf_model.dart';

class PaymentService {
  Future<GeneratePdfModel?> generatePDFApiService({
    required String name,
    required String amount,
    required String type,
  }) async {
    final params = {
      ApiKeys.name: name,
      ApiKeys.amount: amount,
      ApiKeys.type: type,
    };
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.generatePDFApi,
      showProgress: true,
      params: params,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        GeneratePdfModel generatePdfModel = generatePdfModelFromJson(res.response.toString());
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          if (generatePdfModel.code == '200') {
            if (kDebugMode) {
              print('generatePdf success :::: ${jsonDecode(res.response!.data)['msg'].length}');
            }
            Utils.validationCheck(message: generatePdfModel.msg);
          } else {
            if (kDebugMode) {
              print('generatePdf error :::: ${jsonDecode(res.response!.data)['msg']}');
            }
            Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
          }
        } else {
          if (kDebugMode) {
            print('generatePdf error :::: ${jsonDecode(res.response!.data)['msg']}');
          }
          Utils.validationCheck(message: jsonDecode(res.response!.data)['msg'], isSuccess: false);
        }
      },
    );
    return generatePdfModelFromJson(response.response.toString());
  }
}
