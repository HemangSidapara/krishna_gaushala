import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// ignore: library_prefixes
import 'package:get/get.dart' as GetX;
import 'package:krishna_gaushala/app/Constants/api_urls.dart';
import 'package:krishna_gaushala/app/Constants/app_constance.dart';
import 'package:krishna_gaushala/app/Constants/get_storage.dart';
import 'package:krishna_gaushala/app/Network/ResponseModel.dart';
import 'package:krishna_gaushala/app/utils/progress_dialog.dart';
import 'package:krishna_gaushala/app/utils/utils.dart';

class ApiBaseHelper {
  static const String baseUrl = ApiUrls.baseUrl;
  static bool showProgressDialog = true;

  static BaseOptions opts = BaseOptions(
    baseUrl: baseUrl,
    responseType: ResponseType.json,
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 5000),
    sendTimeout: const Duration(milliseconds: 10000),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    }
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    ///For Print Logs
    if (!kReleaseMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          error: true,
          responseHeader: true,
        ),
      );
    }

    ///For Show Hide Progress Dialog
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options, handler) async {
            if (GetX.Get.isOverlaysOpen) {
              await GetX.Get.closeCurrentSnackbar();
            }
            if (showProgressDialog) ProgressDialog.showProgressDialog(true);
            Logger.printLog(tag: '|---------------> ${options.method} JSON METHOD <---------------|\n\n REQUEST_URL :', printLog: '\n ${options.uri} \n\n REQUEST_HEADER : ${options.headers}  \n\n REQUEST_DATA : ${options.data.toString()}', logIcon: Logger.info);
            return requestInterceptor(options, handler);
          },
          onResponse: (response, handler) async {
            ProgressDialog.showProgressDialog(false);
            showProgressDialog = true;

            if (response.statusCode! >= 100 && response.statusCode! <= 199) {
              Logger.printLog(tag: 'WARNING CODE ${response.statusCode} : ', printLog: response.data.toString(), logIcon: Logger.warning);
            } else {
              Logger.printLog(tag: 'SUCCESS CODE ${response.statusCode} : ', printLog: response.data.toString(), logIcon: Logger.success);
            }

            /// change after upgrade
            return handler.next(response);
          },
          onError: (DioError e, handler) async {
            ProgressDialog.showProgressDialog(false);
            showProgressDialog = true;

            e.toString();
            Logger.printLog(tag: 'ERROR CODE ${e.response?.statusCode ?? e.toString()} : ', printLog: e.response?.data.toString(), logIcon: Logger.error);

            return handler.next(e);
          },
        ),
      );
  }

  static dynamic requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    // Get your JWT token
    options.headers.addAll({"Authorization": "Bearer ${getData(AppConstance.authorizationToken)}"});
    return handler.next(options);
  }

  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  Future<ResponseModel> postHTTP(
    String url, {
    dynamic params,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      showProgressDialog = showProgress;
      Response response = await baseAPI.post(
        url,
        data: params,
        queryParameters: queryParameters,
      );
      return handleResponse(response, onError!, onSuccess!);
    } on DioError catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  Future<ResponseModel> deleteHTTP(
    String url, {
    dynamic params,
    dynamic queryParams,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
  }) async {
    try {
      showProgressDialog = showProgress;
      Response response = await baseAPI.delete(
        url,
        data: params,
      );
      return handleResponse(response, onError!, onSuccess!);
    } on DioError catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  Future<ResponseModel> getHTTP(
    String url, {
    dynamic params,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
  }) async {
    try {
      showProgressDialog = showProgress;
      Response response = await baseAPI.get(
        url,
        queryParameters: params,
      );
      return handleResponse(response, onError!, onSuccess!);
    } on DioError catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  Future<ResponseModel> putHTTP(
    String url, {
    dynamic params,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
  }) async {
    try {
      showProgressDialog = showProgress;
      Response response = await baseAPI.put(
        url,
        queryParameters: params,
      );
      return handleResponse(response, onError!, onSuccess!);
    } on DioError catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  handleResponse(Response response, Function(DioExceptions dioExceptions) onError, Function(ResponseModel res) onSuccess) {
    var successModel = ResponseModel(statusCode: response.statusCode, response: response);
    onSuccess(successModel);
    return successModel;
  }

  static handleError(DioError e, Function(DioExceptions dioExceptions) onError, Function(ResponseModel res) onSuccess) {
    switch (e.type) {
      case DioErrorType.badResponse:
        var errorModel = ResponseModel(statusCode: e.response!.statusCode, response: e.response);
        onSuccess(errorModel);
        return ResponseModel(statusCode: e.response!.statusCode, response: e.response);
      default:
        onError(DioExceptions.fromDioError(e));
      // throw DioExceptions.fromDioError(e);
    }
  }
}

class DioExceptions implements Exception {
  String? message;

  DioExceptions.fromDioError(DioError? dioError) {
    switch (dioError!.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.unknown:
        message = "No internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        message = _handleError(dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error["message"];
      case 500:
        return 'Internal Server Error. Please try again.';
      default:
        return 'Sorry, something went wrong. Please try again.';
    }
  }
}
