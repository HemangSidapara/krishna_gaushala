import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Screens/otp_screen/otp_controller.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';
import 'package:pinput/pinput.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  OtpController controller = Get.put(OtpController());

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
          key: controller.otpFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              children: [
                ///otp
                Pinput(
                  controller: controller.otpController,
                ),
                SizedBox(height: 5.h),

                ///Button
                ElevatedButton(
                  onPressed: () async {
                    await controller.checkOtp();
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
