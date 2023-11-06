import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Network/services/auth_service/login_service.dart';
import 'package:krishna_gaushala/app/Routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool visiblePassword = false;

  ///validate username
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterUsername.tr;
    }
    return null;
  }

  /// validate password
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterPassword;
    }
    return null;
  }

  Future<void> checkLogin() async {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final response = await LoginService().loginApiService(
        username: usernameController.text,
        password: passwordController.text,
      );

      if (response?.code == '200') {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', response!.userId.toString());
        Get.toNamed(Routes.dashboard);
      } else {}
    }
  }
}
