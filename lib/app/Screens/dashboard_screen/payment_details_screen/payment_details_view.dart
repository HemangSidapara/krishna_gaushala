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
                        style: TextButton.styleFrom(
                          elevation: 4,
                          backgroundColor: AppColors.SECONDARY_COLOR,
                          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          '₹ 100',
                          style: TextStyle(
                            color: AppColors.WHITE_COLOR,
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
                        style: TextButton.styleFrom(
                          elevation: 4,
                          backgroundColor: AppColors.SECONDARY_COLOR,
                          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          '₹ 500',
                          style: TextStyle(
                            color: AppColors.WHITE_COLOR,
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
                        style: TextButton.styleFrom(
                          elevation: 4,
                          backgroundColor: AppColors.SECONDARY_COLOR,
                          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          '₹ 1000',
                          style: TextStyle(
                            color: AppColors.WHITE_COLOR,
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
                        style: TextButton.styleFrom(
                          elevation: 4,
                          backgroundColor: AppColors.SECONDARY_COLOR,
                          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          '₹ 2000',
                          style: TextStyle(
                            color: AppColors.WHITE_COLOR,
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

                ///Receipt Extra Fields
                if (widget.tabList[widget.index].type == 'Receipt') ...[
                  Obx(() {
                    return Column(
                      children: [
                        SizedBox(height: 3.h),

                        ///Address
                        TextFormField(
                          controller: controller.addressController,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            return controller.validateAddress(value!);
                          },
                          decoration: InputDecoration(
                            hintText: AppStrings.enterYourAddress,
                            hintStyle: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            labelText: AppStrings.address,
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
                        SizedBox(height: 3.h),

                        ///Purpose of fund
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppStrings.purposeOfFund,
                            style: TextStyle(
                              color: AppColors.SECONDARY_COLOR,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Column(
                            children: [
                              PurposeFundWidget(onTap: () {}, title: AppStrings.nisahayBinvarsiGayBaladShaySarvarFund, index: 0),
                              SizedBox(height: 1.5.h),
                              PurposeFundWidget(onTap: () {}, title: AppStrings.makanBandhkamFund, index: 1),
                              SizedBox(height: 1.5.h),
                              PurposeFundWidget(onTap: () {}, title: AppStrings.generalFund, index: 2),
                              SizedBox(height: 3.h),
                            ],
                          ),
                        ),

                        ///Cash Type
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppStrings.cashType,
                            style: TextStyle(
                              color: AppColors.SECONDARY_COLOR,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Row(
                            children: [
                              ///Cash
                              Flexible(
                                child: CashTypeWidget(
                                    onTap: () {
                                      controller.resetChequeControllers();
                                    },
                                    title: AppStrings.cash,
                                    index: 0),
                              ),
                              SizedBox(width: 3.w),

                              ///Cheque
                              Flexible(
                                child: CashTypeWidget(onTap: () {}, title: AppStrings.cheque, index: 1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),

                        ///Cheque Details
                        if (controller.whichCashType[1]) ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppStrings.chequeDetails,
                              style: TextStyle(
                                color: AppColors.SECONDARY_COLOR,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          SizedBox(height: 1.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Column(
                              children: [
                                ///Cheque Number
                                TextFormField(
                                  controller: controller.chequeNumberController,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    return controller.validateChequeNumber(value!);
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppStrings.enterChequeNumber,
                                    hintStyle: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    labelText: AppStrings.chequeNumber,
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
                                SizedBox(height: 2.h),

                                ///Cheque Date
                                TextFormField(
                                  controller: controller.chequeDateController,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    return controller.validateChequeDate(value!);
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppStrings.enterChequeDate,
                                    hintStyle: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    labelText: AppStrings.chequeDate,
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
                                SizedBox(height: 2.h),

                                ///Bank
                                TextFormField(
                                  controller: controller.bankController,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    return controller.validateBank(value!);
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppStrings.enterBank,
                                    hintStyle: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    labelText: AppStrings.bank,
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
                                SizedBox(height: 2.h),

                                ///Branch
                                TextFormField(
                                  controller: controller.branchController,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    return controller.validateBranch(value!);
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppStrings.enterBranch,
                                    hintStyle: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    labelText: AppStrings.branch,
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
                                SizedBox(height: 2.h),

                                ///Account Number
                                TextFormField(
                                  controller: controller.accountNumberController,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    return controller.validateAccountNumber(value!);
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppStrings.enterAccountNumber,
                                    hintStyle: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    labelText: AppStrings.accountNumber,
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
                                SizedBox(height: 2.h),

                                ///PAN Number
                                TextFormField(
                                  controller: controller.panNumberController,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    return controller.validatePANNumber(value!);
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppStrings.enterPanNumber,
                                    hintStyle: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    labelText: AppStrings.panNumber,
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
                                SizedBox(height: 2.h),
                              ],
                            ),
                          ),
                        ],
                      ],
                    );
                  }),
                ],

                ///Niran & Gau Dohan Extra Fields
                if (widget.tabList[widget.index].type == 'Niran' || widget.tabList[widget.index].type == 'Gau Dohan') ...[
                  SizedBox(height: 3.h),
                  TextFormField(
                    controller: controller.quantityController,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      return controller.validateQuantity(value!);
                    },
                    decoration: InputDecoration(
                      hintText: AppStrings.enterQuantity,
                      hintStyle: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      labelText: AppStrings.quantity,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget PurposeFundWidget({required VoidCallback onTap, required String title, required int index}) {
    return Obx(() {
      return InkWell(
        onTap: () {
          for (int i = 0; i < controller.isPurposeFundSelected.length; i++) {
            if (index == i) {
              controller.isPurposeFundSelected[i] = !controller.isPurposeFundSelected[i];
            }
          }
          onTap.call();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///CheckBox
            AnimatedContainer(
              padding: EdgeInsets.all(0.5.w),
              decoration: BoxDecoration(
                color: controller.isPurposeFundSelected[index] ? AppColors.SECONDARY_COLOR : AppColors.WHITE_COLOR,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColors.SECONDARY_COLOR,
                  width: 1,
                ),
              ),
              duration: const Duration(milliseconds: 600),
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
                title,
                style: TextStyle(
                  color: AppColors.SECONDARY_COLOR,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // ignore: non_constant_identifier_names
  Widget CashTypeWidget({required VoidCallback onTap, required String title, required int index}) {
    return Obx(() {
      return InkWell(
        onTap: () {
          for (int i = 0; i < controller.whichCashType.length; i++) {
            if (controller.whichCashType[i] && index != i) {
              controller.whichCashType[i] = false;
            }
            if (index == i) {
              controller.whichCashType[i] = true;
            }
          }
          onTap.call();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///CheckBox
            AnimatedContainer(
              padding: EdgeInsets.all(0.5.w),
              decoration: BoxDecoration(
                color: controller.whichCashType[index] ? AppColors.SECONDARY_COLOR : AppColors.WHITE_COLOR,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColors.SECONDARY_COLOR,
                  width: 1,
                ),
              ),
              duration: const Duration(milliseconds: 600),
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
                title,
                style: TextStyle(
                  color: AppColors.SECONDARY_COLOR,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
