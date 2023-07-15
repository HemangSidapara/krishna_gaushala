import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Routes/app_pages.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_controller.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/payment_details_screen/payment_details_view.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  DashboardController controller = Get.put(DashboardController());

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
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: AppColors.SECONDARY_COLOR,
                size: 6.w,
              ),
              onPressed: () {
                Get.toNamed(Routes.settings);
              },
            )
          ],
          title: Text(
            AppStrings.krishnaGaushala.tr,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.SECONDARY_COLOR,
            ),
          ),
          elevation: 0,
          leading: const SizedBox(),
        ),
        body: Obx(() {
          return Center(
            child: controller.isLoading.value
                ? CircularProgressIndicator(color: AppColors.SECONDARY_COLOR)
                : controller.tabsList.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            color: AppColors.PRIMARY_COLOR,
                            width: double.maxFinite,
                            alignment: Alignment.center,
                            child: Text(
                              AppStrings.asADonationGiftService.tr,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.SECONDARY_COLOR,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            color: AppColors.PRIMARY_COLOR,
                            child: TabBar(
                              controller: controller.tabController,
                              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h).copyWith(bottom: 0),
                              labelPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                              labelStyle: TextStyle(
                                color: AppColors.SECONDARY_COLOR,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              unselectedLabelColor: AppColors.BLACK_COLOR.withOpacity(0.5),
                              unselectedLabelStyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              indicatorColor: AppColors.SECONDARY_COLOR,
                              indicator: UnderlineTabIndicator(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: AppColors.SECONDARY_COLOR,
                                  width: 2.3,
                                ),
                              ),
                              isScrollable: true,
                              tabs: [
                                for (int index = 0; index < controller.tabsList.length; index++)
                                  Text(
                                    controller.tabsList[index].type.toString().tr ?? '',
                                    style: TextStyle(
                                      color: controller.tabsList[index].type == 'Expense List' ? AppColors.ERROR_COLOR : null,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: controller.tabController,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                for (int index = 0; index < controller.tabsList.length; index++)
                                  PaymentDetailsView(
                                    index: index,
                                    tabList: controller.tabsList,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Text(
                        AppStrings.temporaryServiceIsNotAvailable.tr,
                        style: TextStyle(
                          color: AppColors.SECONDARY_COLOR,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
          );
        }),
      ),
    );
  }
}
