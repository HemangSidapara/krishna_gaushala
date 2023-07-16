import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/cost_details_screen/cost_details_controller.dart';
import 'package:krishna_gaushala/app/Utils/app_formatter.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';
import 'package:krishna_gaushala/app/Widgets/get_date_widget.dart';
import 'package:share_plus/share_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class CostDetailsView extends StatefulWidget {
  const CostDetailsView({Key? key}) : super(key: key);

  @override
  State<CostDetailsView> createState() => _CostDetailsViewState();
}

class _CostDetailsViewState extends State<CostDetailsView> {
  CostDetailsController controller = Get.find<CostDetailsController>();

  GlobalKey<FormState> editPdfFormKey = GlobalKey<FormState>();

  FocusNode searchFocusNode = FocusNode();

  final PdfViewerController _pdfViewerController = PdfViewerController();
  OverlayEntry? _overlayEntry;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      setState(() {});
    });
  }

  ///PDF selection menu
  void _showContextMenu(BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 60,
        left: details.globalSelectedRegion!.bottomLeft.dx,
        child: ElevatedButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: details.selectedText ?? ''));
            _pdfViewerController.clearSelection();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 10,
          ),
          child: Text('Copy', style: TextStyle(fontSize: 17, color: AppColors.BLACK_COLOR)),
        ),
      ),
    );
    overlayState.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 800),
              curve: Curves.fastOutSlowIn,
            );
          },
          backgroundColor: AppColors.SECONDARY_COLOR,
          child: Icon(
            Icons.arrow_drop_up_rounded,
            color: AppColors.WHITE_COLOR,
            size: 8.w,
          ),
        ),
        appBar: AppBar(
          backgroundColor: AppColors.PRIMARY_COLOR,
          centerTitle: true,
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(
          //       Icons.add_rounded,
          //       color: AppColors.SECONDARY_COLOR,
          //       size: 7.w,
          //     ),
          //     onPressed: () {
          //       Get.toNamed(
          //         Routes.addCostDetails,
          //         arguments: {
          //           'isEdit': false,
          //           'editableData': null,
          //         },
          //       );
          //     },
          //   )
          // ],
          title: Text(
            AppStrings.costDetails.tr,
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
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.SECONDARY_COLOR,
              ),
            );
          }
          return Column(
            children: [
              ///SearchField
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                child: TextFormField(
                  controller: controller.searchController,
                  focusNode: searchFocusNode,
                  style: TextStyle(
                    color: AppColors.SECONDARY_COLOR,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  onChanged: (value) async {
                    await getSearchedList(searchedValue: value);
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0.5.h),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: searchFocusNode.hasFocus ? AppColors.SECONDARY_COLOR : Colors.grey,
                      size: 6.w,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.SECONDARY_COLOR, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.SECONDARY_COLOR, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: AppStrings.searchByTitle.tr,
                    hintStyle: TextStyle(
                      color: AppColors.BLACK_COLOR.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                  cursorColor: AppColors.SECONDARY_COLOR,
                ),
              ),

              if (controller.expenseList.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      AppStrings.noDataAvailable.tr,
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              else
                ListView.separated(
                  itemCount: controller.expenseList.length,
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h).copyWith(right: 5.w),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        await showViewPdfBottomSheet(url: controller.expenseList[index].url!);
                      },
                      child: Padding(
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
                                        controller.expenseList[index].name ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.SECONDARY_COLOR,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp,
                                        ),
                                      ),

                                      ///S.R No.
                                      Text(
                                        'S.R. No.: ${controller.expenseList[index].spendId}',
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
                                          controller.expenseList[index].amount!.toString().toRupees(),
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
                                      GetDateOrTime().getNonSuffixDate(controller.expenseList[index].datetime!),
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
                                      if (controller.expenseList[index].url != null) {
                                        if (controller.expenseList[index].phone != null && controller.expenseList[index].phone != '') {
                                          String contactNo = controller.expenseList[index].phone!;
                                          String waUrl = 'whatsapp://send?phone=+91$contactNo&text=Your receipt is here👇\n${controller.expenseList[index].url}';
                                          String waWebUrl = 'https://wa.me/+91$contactNo?text=Your receipt is here👇\n${controller.expenseList[index].url}';
                                          try {
                                            await launchUrl(
                                              Uri.parse(waUrl),
                                              mode: LaunchMode.externalApplication,
                                            );
                                          } on PlatformException catch (e) {
                                            if (kDebugMode) {
                                              print('onError sharePdf to WA :: ${e.code}');
                                            }
                                            if (e.code == 'ACTIVITY_NOT_FOUND') {
                                              await launchUrl(
                                                Uri.parse(waWebUrl),
                                                mode: LaunchMode.externalApplication,
                                              );
                                            }
                                          }
                                        } else {
                                          await Share.share(controller.expenseList[index].url!, subject: 'Share Receipt to person.');
                                        }
                                      }
                                    } else if (value == 'edit') {
                                      controller.amountController.text = controller.expenseList[index].amount ?? '';
                                      controller.nameController.text = controller.expenseList[index].name ?? '';
                                      controller.phoneController.text = controller.expenseList[index].phone ?? '';
                                      controller.addressController.text = controller.expenseList[index].address ?? '';
                                      controller.whichCashType[0] = controller.expenseList[index].cash == 'Yes' ? true : false;
                                      controller.whichCashType[1] = controller.expenseList[index].cash == 'No' ? true : false;
                                      controller.whichExpenseType.value = controller.expenseTypeList.indexOf(controller.expenseList[index].type ?? '');
                                      controller.chequeNumberController.text = controller.expenseList[index].chequeNumber ?? '';
                                      controller.voucherDateController.text = controller.expenseList[index].datetime?.replaceAll('-', '/') ?? '';
                                      controller.expenseTypeController.text = controller.expenseList[index].other ?? '';
                                      controller.notesController.text = controller.expenseList[index].notes ?? '';

                                      await showEditPdfBottomSheet(
                                        spendId: controller.expenseList[index].spendId ?? '',
                                      );
                                    } else if (value == 'delete') {
                                      await showDeletePdfDialog(spendId: controller.expenseList[index].spendId ?? '');
                                    } else if (value == 'view') {
                                      await showViewPdfBottomSheet(url: controller.expenseList[index].url ?? '');
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
                                          AppStrings.edit.tr,
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
                                          AppStrings.delete.tr,
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

                                      ///View
                                      PopupMenuItem(
                                        value: 'view',
                                        child: Text(
                                          AppStrings.view.tr,
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
                                          AppStrings.share.tr,
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
                          ],
                        ),
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
          );
        }),
      ),
    );
  }

  showEditPdfBottomSheet({
    required String spendId,
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
                    AppStrings.editGeneratedReceipt.tr,
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
                            SizedBox(height: 5.h),

                            ///ExpenseList
                            Obx(() {
                              return Column(
                                children: [
                                  DropdownButtonFormField(
                                    value: controller.whichExpenseType.value != -1 ? controller.whichExpenseType.value : null,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppColors.SECONDARY_COLOR,
                                      size: 4.w,
                                    ),
                                    validator: (value) {
                                      return controller.validateExpenseList(value);
                                    },
                                    decoration: InputDecoration(
                                      hintText: AppStrings.selectExpenseType.tr,
                                      hintStyle: TextStyle(
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
                                    items: [
                                      for (int i = 0; i < controller.expenseTypeList.length; i++)
                                        DropdownMenuItem(
                                          value: i,
                                          child: Text(
                                            controller.expenseTypeList[i].tr,
                                            style: TextStyle(
                                              color: AppColors.SECONDARY_COLOR,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                    ],
                                    onChanged: (value) {
                                      controller.whichExpenseType(value ?? -1);
                                    },
                                  ),
                                  SizedBox(height: 3.h),

                                  ///Expense Type
                                  if (controller.whichExpenseType.value == 9) ...[
                                    TextFormField(
                                      controller: controller.expenseTypeController,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        return controller.validateExpenseType(value!);
                                      },
                                      decoration: InputDecoration(
                                        hintText: AppStrings.enterExpenseType.tr,
                                        hintStyle: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        labelText: AppStrings.expenseType.tr,
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
                                ],
                              );
                            }),

                            ///Name
                            TextFormField(
                              controller: controller.nameController,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                return controller.validateName(value!);
                              },
                              decoration: InputDecoration(
                                hintText: AppStrings.enterPersonName.tr,
                                hintStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: AppStrings.personName.tr,
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

                            ///Notes
                            TextFormField(
                              controller: controller.notesController,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                return controller.validateNotes(value!);
                              },
                              minLines: 1,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: AppStrings.note.tr,
                                hintStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: AppStrings.note.tr,
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

                            ///PhoneNumber
                            TextFormField(
                              controller: controller.phoneController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              validator: (value) {
                                return controller.validatePhoneNumber(value!);
                              },
                              decoration: InputDecoration(
                                hintText: AppStrings.enterPhoneNumber.tr,
                                hintStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: AppStrings.phoneNumber.tr,
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

                            ///Address
                            TextFormField(
                              controller: controller.addressController,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: AppStrings.enterYourAddress.tr,
                                hintStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: AppStrings.address.tr,
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

                            ///Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///Cancel
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    controller.resetControllers();
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
                                    AppStrings.cancel.tr,
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
                                    if (editPdfFormKey.currentState!.validate()) {
                                      await controller.checkEditPDFApi(spendId: spendId);
                                    }
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
                                    AppStrings.edit.tr,
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

  showDeletePdfDialog({required String spendId}) async {
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
                AppStrings.areYouSureYouWantToDeleteThisReceipt.tr,
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
                      fixedSize: Size(32.w, 6.h),
                    ),
                    child: Text(
                      AppStrings.cancel.tr,
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),

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
                      fixedSize: Size(32.w, 6.h),
                    ),
                    child: Text(
                      AppStrings.delete.tr,
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

  Future<void> getSearchedList({required String searchedValue}) async {
    if (searchedValue.trim() != "" && searchedValue.isNotEmpty) {
      resetSearchedList();
      controller.expenseList.addAll(
        controller.defaultExpenseList.where((e) {
          return e.name!.toLowerCase().contains(searchedValue.toLowerCase());
        }).toList(),
      );
    } else {
      resetSearchedList();
      controller.expenseList.addAll(controller.defaultExpenseList);
    }
  }

  void resetSearchedList() {
    controller.expenseList.clear();
  }

  showViewPdfBottomSheet({required String url}) async {
    return await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: AppColors.WHITE_COLOR,
      constraints: BoxConstraints(maxHeight: 90.h, minHeight: 40.h, maxWidth: 100.w, minWidth: 100.w),
      isScrollControlled: true,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(100.w, 10.h),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.SECONDARY_COLOR,
                ),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h).copyWith(right: 2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PDF Viewer',
                      style: TextStyle(
                        color: AppColors.WHITE_COLOR,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        color: AppColors.WHITE_COLOR,
                        size: 7.w,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: SfTheme(
              data: SfThemeData(
                pdfViewerThemeData: SfPdfViewerThemeData(
                  progressBarColor: AppColors.WARNING_COLOR,
                ),
              ),
              child: SfPdfViewer.network(
                url,
                currentSearchTextHighlightColor: AppColors.PRIMARY_COLOR,
                onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
                  if (details.selectedText == null && _overlayEntry != null) {
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                  } else if (details.selectedText != null && _overlayEntry == null) {
                    _showContextMenu(context, details);
                  }
                },
                controller: _pdfViewerController,
              ),
            ),
          ),
        );
      },
    );
  }
}
