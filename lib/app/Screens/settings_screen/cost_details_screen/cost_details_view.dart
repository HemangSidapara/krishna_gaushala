import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Routes/app_pages.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/cost_details_controller.dart';
import 'package:krishna_gaushala/app/Utils/app_formatter.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';
import 'package:krishna_gaushala/app/Widgets/get_date_widget.dart';

class CostDetailsView extends StatefulWidget {
  const CostDetailsView({Key? key}) : super(key: key);

  @override
  State<CostDetailsView> createState() => _CostDetailsViewState();
}

class _CostDetailsViewState extends State<CostDetailsView> {
  CostDetailsController controller = Get.find<CostDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_rounded,
              color: AppColors.SECONDARY_COLOR,
              size: 7.w,
            ),
            onPressed: () {
              Get.toNamed(
                Routes.addCostDetails,
                arguments: {
                  'isEdit': false,
                  'editableData': null,
                },
              );
            },
          )
        ],
        title: Text(
          AppStrings.costDetails,
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
      body: Obx(() {
        return controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(color: AppColors.SECONDARY_COLOR),
              )
            : controller.costDetailsList.isEmpty
                ? Center(
                    child: Text(
                      'No Data Available',
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: controller.costDetailsList.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h).copyWith(right: 5.w),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///Title, Amount
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///Title
                                Expanded(
                                  child: Text(
                                    controller.costDetailsList[index].spendTo!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.SECONDARY_COLOR,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.w),

                                ///Amount
                                Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee_rounded,
                                      color: AppColors.SECONDARY_COLOR,
                                      size: 10.sp,
                                    ),
                                    Text(
                                      controller.costDetailsList[index].amount!.toRupees(),
                                      style: TextStyle(
                                        color: AppColors.SECONDARY_COLOR,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    PopupMenuButton(
                                      onSelected: (value) async {
                                        if (value == 'edit') {
                                          Get.toNamed(
                                            Routes.addCostDetails,
                                            arguments: {
                                              'isEdit': true,
                                              'editableData': controller.costDetailsList[index],
                                            },
                                          );
                                        } else if (value == 'delete') {
                                          await showDeleteSpendsDialog(spendId: controller.costDetailsList[index].spendId!);
                                        }
                                      },
                                      position: PopupMenuPosition.under,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      itemBuilder: (context) {
                                        return [
                                          ///Edit
                                          PopupMenuItem(
                                            value: 'edit',
                                            child: Text(
                                              'Edit',
                                              style: TextStyle(
                                                color: AppColors.SECONDARY_COLOR,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            height: 0,
                                            child: PopupMenuDivider(height: 0),
                                          ),

                                          ///Delete
                                          PopupMenuItem(
                                            value: 'delete',
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                color: AppColors.SECONDARY_COLOR,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ];
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 0.5.h),

                            ///Note
                            Text(
                              controller.costDetailsList[index].notes!,
                              style: TextStyle(
                                color: AppColors.SECONDARY_COLOR.withOpacity(0.7),
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(height: 0.5.h),

                            ///Date
                            Row(
                              children: [
                                Icon(
                                  Icons.circle_rounded,
                                  color: AppColors.SECONDARY_COLOR.withOpacity(0.5),
                                  size: 5.sp,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  GetDateOrTime().getNonSuffixDate(controller.costDetailsList[index].datetime!),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 8.sp,
                                    color: AppColors.SECONDARY_COLOR.withOpacity(0.5),
                                  ),
                                ),
                              ],
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
                  );
      }),
    );
  }

  showDeleteSpendsDialog({
    required String spendId,
  }) async {
    return await showGeneralDialog(
      context: context,
      barrierLabel: 'delete',
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColors.WHITE_COLOR,
          surfaceTintColor: AppColors.WHITE_COLOR,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///Icon
              Icon(
                Icons.error_rounded,
                color: AppColors.WARNING_COLOR,
                size: 5.w,
              ),
              SizedBox(height: 2.h),

              ///ConfirmNote
              Text(
                'Are you sure, you want to delete this cost details?',
                style: TextStyle(
                  color: AppColors.SECONDARY_COLOR,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),

              ///Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///Cancel
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.WHITE_COLOR,
                      surfaceTintColor: AppColors.WHITE_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      side: BorderSide(
                        color: AppColors.SECONDARY_COLOR,
                        width: 1,
                      ),
                      fixedSize: Size(35.w, 6.h),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  ///Delete
                  ElevatedButton(
                    onPressed: () async {
                      await controller.checkDeleteCostDetail(spendId: spendId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ERROR_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      fixedSize: Size(35.w, 6.h),
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: AppColors.WHITE_COLOR,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }
}
