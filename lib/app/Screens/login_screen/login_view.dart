import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Screens/login_screen/login_controller.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.PRIMARY_COLOR,
          centerTitle: true,
          title: Text(
            AppStrings.login.tr,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.SECONDARY_COLOR,
            ),
          ),
          elevation: 4,
          leading: const SizedBox(),
        ),
        body: Form(
          key: controller.loginFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              children: [
                ///Username
                TextFormField(
                  controller: controller.usernameController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    return controller.validateEmail(value!);
                  },
                  decoration: InputDecoration(
                      hintText: AppStrings.enterUsername.tr,
                      hintStyle: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      labelText: AppStrings.username.tr,
                      labelStyle: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.SECONDARY_COLOR,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.BLACK_COLOR.withOpacity(0.6),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusColor: AppColors.BLACK_COLOR.withOpacity(0.6)),
                ),
                SizedBox(height: 2.h),

                ///Password
                TextFormField(
                  controller: controller.passwordController,
                  obscureText: !controller.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return controller.validatePassword(value!);
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.visiblePassword ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                          color: controller.visiblePassword ? AppColors.SECONDARY_COLOR : AppColors.BLACK_COLOR.withAlpha(70),
                          size: 5.w,
                        ),
                        onPressed: () {
                          setState(() {
                            controller.visiblePassword = !controller.visiblePassword;
                          });
                        },
                      ),
                      hintText: AppStrings.enterPassword.tr,
                      hintStyle: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      labelText: AppStrings.password.tr,
                      labelStyle: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.SECONDARY_COLOR,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.BLACK_COLOR.withOpacity(0.6),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusColor: AppColors.BLACK_COLOR.withOpacity(0.6)),
                ),
                SizedBox(height: 5.h),

                ///Button
                ElevatedButton(
                  onPressed: () async {
                    await controller.checkLogin();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.SECONDARY_COLOR,
                    fixedSize: Size(100.w, 5.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                  ),
                  child: Text(
                    AppStrings.login.tr,
                    style: TextStyle(
                      color: AppColors.WHITE_COLOR,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
