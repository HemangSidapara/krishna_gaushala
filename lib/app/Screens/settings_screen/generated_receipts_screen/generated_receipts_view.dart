import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/generated_receipts_screen/generated_receipts_controller.dart';
import 'package:krishna_gaushala/app/Utils/app_formatter.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';
import 'package:krishna_gaushala/app/Widgets/get_date_widget.dart';
import 'package:share_plus/share_plus.dart';

class GeneratedReceiptsView extends StatefulWidget {
  const GeneratedReceiptsView({Key? key}) : super(key: key);

  @override
  State<GeneratedReceiptsView> createState() => _GeneratedReceiptsViewState();
}

class _GeneratedReceiptsViewState extends State<GeneratedReceiptsView> {
  GeneratedReceiptsController controller = Get.find<GeneratedReceiptsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: true,
        title: Text(
          AppStrings.generatedReceipts,
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
            : controller.invoicesList.isEmpty
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
                    itemCount: controller.invoicesList.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h).copyWith(right: 5.w),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///Title, Amount & Date
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ///Title & S.R. No.
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ///Title
                                      Text(
                                        controller.invoicesList[index].name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.SECONDARY_COLOR,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp,
                                        ),
                                      ),

                                      ///S.R No.
                                      Text(
                                        'S.R. No.: ${controller.invoicesList[index].billId}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 8.sp,
                                          color: AppColors.SECONDARY_COLOR.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 2.w),

                                ///Amount & Date
                                Column(
                                  children: [
                                    ///Amount
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee_rounded,
                                          color: AppColors.SECONDARY_COLOR,
                                          size: 10.sp,
                                        ),
                                        Text(
                                          controller.invoicesList[index].amount!.toRupees(),
                                          style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),

                                    ///Date
                                    Text(
                                      GetDateOrTime().getNonSuffixDate(controller.invoicesList[index].datetime!),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 8.sp,
                                        color: AppColors.SECONDARY_COLOR.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),

                                ///Share
                                IconButton(
                                  icon: Icon(
                                    Icons.share_rounded,
                                    color: AppColors.SECONDARY_COLOR,
                                    size: 6.w,
                                  ),
                                  onPressed: () async {
                                    if (controller.invoicesList[index].url != null) {
                                      await Share.share(controller.invoicesList[index].url!, subject: 'Share Receipt to person.');
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 0.5.h),
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
}
