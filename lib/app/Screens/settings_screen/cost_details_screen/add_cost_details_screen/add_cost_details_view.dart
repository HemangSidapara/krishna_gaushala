import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/add_cost_details_screen/add_cost_details_controller.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/add_cost_details_screen/add_cost_details_field.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';

class AddCostDetailsView extends StatefulWidget {
  const AddCostDetailsView({Key? key}) : super(key: key);

  @override
  State<AddCostDetailsView> createState() => _AddCostDetailsViewState();
}

class _AddCostDetailsViewState extends State<AddCostDetailsView> {
  AddCostDetailsController controller = Get.find<AddCostDetailsController>();

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
          title: Text(
            Get.arguments['isEdit'] == true ? AppStrings.editCostDetails.tr : AppStrings.addCostDetails.tr,
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
        resizeToAvoidBottomInset: false,
        body: DefaultTabController(
          length: 6,
          child: Column(
            children: [
              Container(
                color: AppColors.PRIMARY_COLOR,
                child: TabBar(
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
                    for (int index = 0; index < 6; index++)
                      const Text(
                        'Sarvar' ?? '',
                      ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    for (int index = 0; index < 6; index++) const AddCostDetailsFields(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
