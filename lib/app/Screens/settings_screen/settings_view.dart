import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
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

  bool languageExpanded = false;
  bool selectedGujarati = Get.locale == const Locale('gu', 'IN') ? true : false;
  bool selectedEnglish = Get.locale == const Locale('en', 'IN') ? true : false;

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
              return InkWell(
                onTap: () {
                  if (index == 0) {
                    Get.toNamed(Routes.costDetails);
                  } else if (index == 1) {
                    Get.toNamed(Routes.generatedReceipts);
                  }
                },
                child: Row(
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: AppColors.SECONDARY_COLOR,
                        size: 5.w,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: AppColors.SECONDARY_COLOR.withOpacity(0.5),
                thickness: 1,
              );
            },
          ),

          ExpansionTile(
            onExpansionChanged: (value) {
              setState(() {
                languageExpanded = value;
              });
            },
            shape: InputBorder.none,
            tilePadding: EdgeInsets.only(left: 9.w, right: 5.w),
            trailing: RotatedBox(
              quarterTurns: languageExpanded ? -2 : 0,
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.SECONDARY_COLOR,
                size: 5.w,
              ),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.translate_rounded,
                  color: AppColors.SECONDARY_COLOR,
                  size: 5.5.w,
                ),
                SizedBox(width: 3.w),
                Text(
                  AppStrings.changeLanguage.tr,
                  style: TextStyle(
                    color: AppColors.SECONDARY_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            childrenPadding: EdgeInsets.only(left: 9.w, right: 5.w),
            children: [
              Divider(
                color: AppColors.SECONDARY_COLOR.withOpacity(0.5),
                thickness: 1,
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///English
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedEnglish = true;
                          selectedGujarati = false;
                          Get.updateLocale(const Locale('en', 'IN'));
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///CheckBox
                          AnimatedContainer(
                            padding: EdgeInsets.all(0.5.w),
                            decoration: BoxDecoration(
                              color: selectedEnglish ? AppColors.SECONDARY_COLOR : AppColors.WHITE_COLOR,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: AppColors.SECONDARY_COLOR,
                                width: 1,
                              ),
                            ),
                            duration: const Duration(milliseconds: 400),
                            child: Icon(
                              Icons.done_rounded,
                              color: AppColors.WHITE_COLOR,
                              size: 4.w,
                            ),
                          ),
                          SizedBox(width: 3.w),

                          ///Title
                          Flexible(
                            child: Text(
                              AppStrings.english.tr,
                              style: TextStyle(
                                color: AppColors.SECONDARY_COLOR,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///Gujarati
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedGujarati = true;
                          selectedEnglish = false;
                          Get.updateLocale(const Locale('gu', 'IN'));
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///CheckBox
                          AnimatedContainer(
                            padding: EdgeInsets.all(0.5.w),
                            decoration: BoxDecoration(
                              color: selectedGujarati ? AppColors.SECONDARY_COLOR : AppColors.WHITE_COLOR,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: AppColors.SECONDARY_COLOR,
                                width: 1,
                              ),
                            ),
                            duration: const Duration(milliseconds: 400),
                            child: Icon(
                              Icons.done_rounded,
                              color: AppColors.WHITE_COLOR,
                              size: 4.w,
                            ),
                          ),
                          SizedBox(width: 3.w),

                          ///Title
                          Flexible(
                            child: Text(
                              AppStrings.gujarati.tr,
                              style: TextStyle(
                                color: AppColors.SECONDARY_COLOR,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
