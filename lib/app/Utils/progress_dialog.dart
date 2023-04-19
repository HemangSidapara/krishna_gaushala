import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';

class ProgressDialog {
  static var isOpen = false;

  static showProgressDialog(bool showDialog) {
    if (showDialog) {
      isOpen = true;
      print('|--------------->🕙️ Loader start 🕑️<---------------|');

      Get.dialog(
        WillPopScope(
          onWillPop: () => Future.value(true),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: AppColors.SECONDARY_COLOR,
                )
              ],
            ),
          ),
        ),
        barrierDismissible: false, /*useRootNavigator: false*/
      );
    } else if (Get.isDialogOpen!) {
      print('|--------------->🕙️ Loader end 🕑️<---------------|');
      Get.back();

      isOpen = false;
    }
  }
}
