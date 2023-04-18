import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';

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

  static void validationCheck({message, title = "Error", isExpandedMargin = false}) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        margin: EdgeInsets.only(bottom: isExpandedMargin ? 12 : 20, left: 10, right: 10),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: title == 'Error' ? AppColors.ERROR_COLOR : AppColors.SUCCESS_COLOR,
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        messageText: Row(
          children: [
            Icon(
              title == 'Error' ? Icons.error_rounded : Icons.check_circle,
              color: AppColors.WHITE_COLOR,
              size: 24,
            ),
            SizedBox(width: 3),
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
