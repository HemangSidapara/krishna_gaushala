import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/generated_receipts_screen/generated_receipts_controller.dart';
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

  GlobalKey<FormState> editPdfFormKey = GlobalKey<FormState>();

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
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Receipts
                  GeneratedReceiptsCategoryList(title: 'Receipts', items: controller.receiptList),

                  ///Niran
                  GeneratedReceiptsCategoryList(title: 'Niran', items: controller.niranList),

                  ///Gau Dohan
                  GeneratedReceiptsCategoryList(title: 'Gau Dohan', items: controller.gauDohanList),

                  ///Vahan Vyavastha
                  GeneratedReceiptsCategoryList(title: 'Vahan Vyavastha', items: controller.vahanVyavasthaList),

                  ///Sarvar
                  GeneratedReceiptsCategoryList(title: 'Sarvar', items: controller.sarvarList),

                  ///Makan Bandhkam
                  GeneratedReceiptsCategoryList(title: 'Makan Bandhkam', items: controller.makanBandhkamList),

                  ///Band Party
                  GeneratedReceiptsCategoryList(title: 'Band Party', items: controller.bandPartyList),
                ],
              );
      }),
    );
  }

  // ignore: non_constant_identifier_names
  Widget GeneratedReceiptsCategoryList({required String title, required List items}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              color: AppColors.SECONDARY_COLOR,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          items.isEmpty
              ? InkWell(
                  onTap: () {
                    showEditPdfBottomSheet(billId: 'billId', type: 'Receipt');
                  },
                  child: Center(
                    child: Text(
                      'No Data Available',
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: items.length,
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
                                      items[index].name!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.SECONDARY_COLOR,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.sp,
                                      ),
                                    ),

                                    ///S.R No.
                                    Text(
                                      'S.R. No.: ${items[index].billId}',
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
                                        items[index].amount!.toRupees(),
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
                                    GetDateOrTime().getNonSuffixDate(items[index].datetime!),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 8.sp,
                                      color: AppColors.SECONDARY_COLOR.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),

                              ///Edit, Delete & Share
                              PopupMenuButton(
                                onSelected: (value) async {
                                  if (value == 'share') {
                                    if (items[index].url != null) {
                                      await Share.share(items[index].url!, subject: 'Share Receipt to person.');
                                    }
                                  } else if (value == 'edit') {
                                    controller.amountController.text = items[index].amount ?? '';
                                    controller.nameController.text = items[index].name ?? '';
                                    await showEditPdfBottomSheet(
                                      billId: items[index].billId!,
                                      type: items[index].type!,
                                    );
                                  } else if (value == 'delete') {
                                    await showDeletePdfDialog(billId: items[index].billId!);
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
                                    const PopupMenuItem(
                                      height: 0,
                                      child: PopupMenuDivider(height: 0),
                                    ),

                                    ///Share
                                    PopupMenuItem(
                                      value: 'share',
                                      child: Text(
                                        'Share',
                                        style: TextStyle(
                                          color: AppColors.SECONDARY_COLOR,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ];
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
                ),
        ],
      ),
    );
  }

  showEditPdfBottomSheet({
    required String billId,
    required String type,
  }) async {
    return await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: AppColors.WHITE_COLOR,
      constraints: BoxConstraints(maxHeight: 90.h, minHeight: 40.h, maxWidth: 100.w, minWidth: 100.w),
      isScrollControlled: true,
      builder: (context) {
        final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h).copyWith(bottom: keyboardPadding != 0 ? keyboardPadding : 2.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ///Title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Edit Generated Receipt',
                    style: TextStyle(
                      color: AppColors.SECONDARY_COLOR,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.7),
                  thickness: 1,
                ),

                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Form(
                        key: editPdfFormKey,
                        child: Column(
                          children: [
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
                            SizedBox(height: 5.h),

                            ///Receipt Extra Fields
                            if (type == 'Receipt') ...[
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
                                            child: CashTypeWidget(onTap: () {}, title: AppStrings.cash, index: 0),
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
                            if (type == 'Niran' || type == 'Gau Dohan') ...[
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

                            ///Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///Cancel
                                ElevatedButton(
                                  onPressed: () {
                                    controller.amountController.clear();
                                    controller.nameController.clear();
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

                                ///Edit
                                ElevatedButton(
                                  onPressed: () async {
                                    await controller.checkEditReceipts(billId: billId, type: type, key: editPdfFormKey);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.SECONDARY_COLOR,
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
                                    'Edit',
                                    style: TextStyle(
                                      color: AppColors.WHITE_COLOR,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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

  showDeletePdfDialog({
    required String billId,
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
                'Are you sure, you want to delete this receipt?',
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
                      await controller.checkDeleteReceipts(billId: billId);
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
