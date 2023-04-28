import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Routes/app_pages.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';

class CostDetailsView extends StatefulWidget {
  const CostDetailsView({Key? key}) : super(key: key);

  @override
  State<CostDetailsView> createState() => _CostDetailsViewState();
}

class _CostDetailsViewState extends State<CostDetailsView> {
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
              Get.toNamed(Routes.addCostDetails);
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
    );
  }
}
