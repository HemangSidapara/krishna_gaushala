import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_model/get_types_model.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/payment_details_screen/payment_details_controller.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';

class PaymentDetailsView extends StatefulWidget {
  final int index;
  final List<Data> tabList;

  const PaymentDetailsView({
    Key? key,
    required this.index,
    required this.tabList,
  }) : super(key: key);

  @override
  State<PaymentDetailsView> createState() => _PaymentDetailsViewState();
}

class _PaymentDetailsViewState extends State<PaymentDetailsView> {
  PaymentDetailsController controller = Get.find<PaymentDetailsController>();

  GlobalKey<FormState> paymentDetailsFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h).copyWith(top: 0),
        child: ElevatedButton(
          onPressed: () async {
            await controller.checkPayment(
              key: paymentDetailsFormKey,
              index: widget.index,
              tabList: widget.tabList,
            );
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
        key: paymentDetailsFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: keyboardPadding + 15.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h),

                ///Amount
                TextFormField(
                  controller: controller.amountController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
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

                ///Name
                TextFormField(
                  controller: controller.nameController,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return controller.validateName(value!);
                  },
                  decoration: InputDecoration(
                    hintText: AppStrings.enterPersonName,
                    hintStyle: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    labelText: AppStrings.personName,
                    labelStyle: TextStyle(
                      color: AppColors.SECONDARY_COLOR,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.SECONDARY_COLOR,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.BLACK_COLOR.withOpacity(0.6),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusColor: AppColors.BLACK_COLOR.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
