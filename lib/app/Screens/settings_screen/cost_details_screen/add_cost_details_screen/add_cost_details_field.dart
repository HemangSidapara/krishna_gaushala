import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/add_cost_details_screen/add_cost_details_controller.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';
import 'package:krishna_gaushala/app/Widgets/show_date_picker_widget.dart';

class AddCostDetailsFields extends StatefulWidget {
  const AddCostDetailsFields({super.key});

  @override
  State<AddCostDetailsFields> createState() => _AddCostDetailsFieldsState();
}

class _AddCostDetailsFieldsState extends State<AddCostDetailsFields> {
  AddCostDetailsController controller = Get.find<AddCostDetailsController>();

  GlobalKey<FormState> addCostDetailsFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
    return Obx(() {
      return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          resizeToAvoidBottomInset: false,
          bottomSheet: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h).copyWith(top: 0),
            child: ElevatedButton(
              onPressed: () async {
                if (Get.arguments['isEdit'] == true) {
                  await controller.checkEditCostDetails(key: addCostDetailsFormKey, spendId: controller.editableData!.spendId!);
                } else {
                  await controller.checkAddCostDetails(key: addCostDetailsFormKey);
                }
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
                AppStrings.save.tr,
                style: TextStyle(
                  color: AppColors.WHITE_COLOR,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h).copyWith(bottom: keyboardPadding != 0.0 ? keyboardPadding : 0),
            child: Form(
              key: addCostDetailsFormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Amount
                    TextFormField(
                      controller: controller.amountController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return controller.validateAmount(value!);
                      },
                      keyboardType: TextInputType.number,
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
                        hintText: AppStrings.enterAmount.tr,
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
                    SizedBox(height: 3.h),

                    ///Title of Expenditure
                    Text(
                      AppStrings.titleOfExpenditure.tr,
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 0.6.h),

                    ///Title of Expenditure Field
                    TextFormField(
                      controller: controller.titleOfExpenditureController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return controller.validateTitleOfExpenditure(value!);
                      },
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.SECONDARY_COLOR, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.SECONDARY_COLOR, width: 1.5),
                        ),
                        hintText: AppStrings.titleOfExpenditure.tr,
                        hintStyle: TextStyle(
                          color: AppColors.BLACK_COLOR.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                      cursorColor: AppColors.SECONDARY_COLOR,
                    ),
                    SizedBox(height: 2.h),

                    ///Note
                    Text(
                      AppStrings.note.tr,
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 0.6.h),
                    TextFormField(
                      controller: controller.noteController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        return controller.validateNote(value!);
                      },
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      minLines: 3,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.SECONDARY_COLOR, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.SECONDARY_COLOR, width: 1.5),
                        ),
                        hintText: AppStrings.note.tr,
                        hintStyle: TextStyle(
                          color: AppColors.BLACK_COLOR.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                      cursorColor: AppColors.SECONDARY_COLOR,
                    ),
                    SizedBox(height: 2.h),

                    ///Cash Type
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.cashType.tr,
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
                                title: AppStrings.cash.tr,
                                index: 0),
                          ),
                          SizedBox(width: 3.w),

                          ///Cheque
                          Flexible(
                            child: CashTypeWidget(onTap: () {}, title: AppStrings.cheque.tr, index: 1),
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
                          AppStrings.chequeDetails.tr,
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
                                hintText: AppStrings.enterChequeNumber.tr,
                                hintStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: AppStrings.chequeNumber.tr,
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
                              onTap: () async {
                                final selectedDate = await showDatePickerWidget(context: context);
                                if (selectedDate != null) {
                                  controller.chequeDateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
                                }
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: AppStrings.enterChequeDate.tr,
                                hintStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: AppStrings.chequeDate.tr,
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
                                hintText: AppStrings.enterBank.tr,
                                hintStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: AppStrings.bank.tr,
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
                                hintText: AppStrings.enterBranch.tr,
                                hintStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: AppStrings.branch.tr,
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
                                hintText: AppStrings.enterAccountNumber.tr,
                                hintStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: AppStrings.accountNumber.tr,
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
                          ],
                        ),
                      ),
                    ],

                    ///PAN Number
                    TextFormField(
                      controller: controller.panNumberController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: AppStrings.enterPanNumber.tr,
                        hintStyle: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        labelText: AppStrings.panNumber.tr,
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
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // ignore: non_constant_identifier_names
  Widget CashTypeWidget({
    required VoidCallback onTap,
    required String title,
    required int index,
  }) {
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
