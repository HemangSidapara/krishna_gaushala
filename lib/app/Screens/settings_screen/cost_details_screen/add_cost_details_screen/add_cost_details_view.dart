import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/add_cost_details_screen/add_cost_details_controller.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';

class AddCostDetailsView extends StatefulWidget {
  const AddCostDetailsView({Key? key}) : super(key: key);

  @override
  State<AddCostDetailsView> createState() => _AddCostDetailsViewState();
}

class _AddCostDetailsViewState extends State<AddCostDetailsView> {
  AddCostDetailsController controller = Get.find<AddCostDetailsController>();

  GlobalKey<FormState> addCostDetailsFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
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
            AppStrings.addCostDetails,
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
            onPressed: () async {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.SECONDARY_COLOR,
              fixedSize: Size(90.w, 6.h),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              AppStrings.save,
              style: TextStyle(
                color: AppColors.WHITE_COLOR,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        body: Form(
          key: addCostDetailsFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h).copyWith(bottom: keyboardPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///Amount
                  TextFormField(
                    controller: controller.amountController,
                    validator: (value) {
                      return controller.validateAmount(value!);
                    },
                    style: TextStyle(
                      color: AppColors.SECONDARY_COLOR,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.currency_rupee_rounded, color: AppColors.SECONDARY_COLOR, size: 6.w),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.SECONDARY_COLOR, width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.SECONDARY_COLOR, width: 1.5),
                      ),
                      hintText: AppStrings.enterAmount,
                      hintStyle: TextStyle(
                        color: AppColors.BLACK_COLOR.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                    cursorColor: AppColors.SECONDARY_COLOR,
                  ),
                  SizedBox(height: 3.h),

                  ///DefaultAmount
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///₹ 100
                        TextButton(
                          onPressed: () {
                            controller.amountController.text = '100';
                          },
                          child: Text(
                            '₹ 100',
                            style: TextStyle(
                              color: AppColors.SECONDARY_COLOR,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        ///₹ 500
                        TextButton(
                          onPressed: () {
                            controller.amountController.text = '500';
                          },
                          child: Text(
                            '₹ 500',
                            style: TextStyle(
                              color: AppColors.SECONDARY_COLOR,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        ///₹ 1000
                        TextButton(
                          onPressed: () {
                            controller.amountController.text = '1000';
                          },
                          child: Text(
                            '₹ 1000',
                            style: TextStyle(
                              color: AppColors.SECONDARY_COLOR,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        ///₹ 2000
                        TextButton(
                          onPressed: () {
                            controller.amountController.text = '2000';
                          },
                          child: Text(
                            '₹ 2000',
                            style: TextStyle(
                              color: AppColors.SECONDARY_COLOR,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}