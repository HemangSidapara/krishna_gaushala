import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_icons.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Constants/get_storage.dart';
import 'package:krishna_gaushala/app/Routes/app_pages.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: true,
        title: Text(
          AppStrings.settings,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.SECONDARY_COLOR,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.SECONDARY_COLOR,
            size: 6.w,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h).copyWith(top: 0),
        child: ElevatedButton(
          onPressed: () async {
            await clearData();
            Get.offAllNamed(Routes.login);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.SECONDARY_COLOR,
            fixedSize: Size(90.w, 6.h),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            AppStrings.logOut,
            style: TextStyle(
              color: AppColors.WHITE_COLOR,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 2.h),

          ///Cost details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w).copyWith(right: 3.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppIcons.sendMoneyIcon,
                      height: 5.5.w,
                      width: 5.5.w,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      AppStrings.costDetails,
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.costDetails);
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: AppColors.SECONDARY_COLOR,
                    size: 5.w,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
