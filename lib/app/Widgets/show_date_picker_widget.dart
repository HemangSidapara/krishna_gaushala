import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';

Future<DateTime?> showDatePickerWidget({required BuildContext context}) async {
  return await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 100),
    builder: (context, child) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 3,
          sigmaY: 3,
        ),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            color: AppColors.TRANSPARENT,
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.SECONDARY_COLOR,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.SECONDARY_COLOR,
                  ),
                ),
              ),
              child: child!,
            ),
          ),
        ),
      );
    },
  );
}
