import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_icons.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Constants/get_storage.dart';
import 'package:krishna_gaushala/app/Routes/app_pages.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/settings_controller.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  SettingsController controller = Get.find<SettingsController>();

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

          ///List
          ListView.separated(
            itemCount: 2,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h).copyWith(right: 5.w),
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        controller.settingsIconList[index],
                        height: 5.5.w,
                        width: 5.5.w,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        controller.settingsNameList[index],
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
                      if (index == 0) {
                        Get.toNamed(Routes.costDetails);
                      } else if (index == 1) {
                        Get.toNamed(Routes.generatedReceipts);
                      }
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: AppColors.SECONDARY_COLOR,
                      size: 5.w,
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: AppColors.SECONDARY_COLOR.withOpacity(0.5),
                thickness: 1,
              );
            },
          ),
        ],
      ),
    );
  }
}
