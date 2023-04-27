import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';

class Utils {
  static void warningMessage(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Warning!",
        message, /* backgroundColor: ThemeColors.colorWarningMessage, colorText: Colors.black*/
      );
    }
  }

  static void warningMessageWithTitle({String? title, String? message}) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        title ?? "Warning!",
        message!,
      );
    }
  }

  static void handleNetworkError(message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Error",
        message,
      );
    }
  }

  static void validationCheck({message, bool isSuccess = true, isExpandedMargin = false}) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        margin: EdgeInsets.only(bottom: isExpandedMargin ? 12 : 20, left: 10, right: 10),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: isSuccess ? AppColors.SUCCESS_COLOR : AppColors.ERROR_COLOR,
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        messageText: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error_rounded,
              color: AppColors.WHITE_COLOR,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                message ?? 'Empty message',
                style: TextStyle(
                  color: AppColors.WHITE_COLOR,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        borderRadius: 99,
        duration: const Duration(milliseconds: 1500),
      );
    }
  }
}
