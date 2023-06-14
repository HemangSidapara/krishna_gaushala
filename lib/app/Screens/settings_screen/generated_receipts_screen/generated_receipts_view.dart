import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Screens/settings_screen/generated_receipts_screen/generated_receipts_controller.dart';
import 'package:krishna_gaushala/app/Utils/app_formatter.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';
import 'package:krishna_gaushala/app/Widgets/get_date_widget.dart';
import 'package:share_plus/share_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneratedReceiptsView extends StatefulWidget {
  const GeneratedReceiptsView({Key? key}) : super(key: key);

  @override
  State<GeneratedReceiptsView> createState() => _GeneratedReceiptsViewState();
}

class _GeneratedReceiptsViewState extends State<GeneratedReceiptsView> {
  GeneratedReceiptsController controller = Get.find<GeneratedReceiptsController>();

  GlobalKey<FormState> editPdfFormKey = GlobalKey<FormState>();

  FocusNode searchFocusNode = FocusNode();

  final PdfViewerController _pdfViewerController = PdfViewerController();
  OverlayEntry? _overlayEntry;

  List<ExpansionTileController> expansionControllers = List.generate(7, (index) => ExpansionTileController());
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
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
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
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.SECONDARY_COLOR),
            );
          } else {
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
                      hintText: AppStrings.searchByTitle,
                      hintStyle: TextStyle(
                        color: AppColors.BLACK_COLOR.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                    cursorColor: AppColors.SECONDARY_COLOR,
                  ),
                ),

                ///Data
                Flexible(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Receipts
                        GeneratedReceiptsCategoryList(title: 'Receipt', items: controller.receiptList, index: 0),

                        ///Niran
                        GeneratedReceiptsCategoryList(title: 'Niran', items: controller.niranList, index: 1),

                        ///Gau Dohan
                        GeneratedReceiptsCategoryList(title: 'Gau Dohan', items: controller.gauDohanList, index: 2),

                        ///Vahan Vyavastha
                        GeneratedReceiptsCategoryList(title: 'Vahan Vyavastha', items: controller.vahanVyavasthaList, index: 3),

                        ///Sarvar
                        GeneratedReceiptsCategoryList(title: 'Sarvar', items: controller.sarvarList, index: 4),

                        ///Makan Bandhkam
                        GeneratedReceiptsCategoryList(title: 'Makan Bandhkam', items: controller.makanBandhkamList, index: 5),

                        ///Band Party
                        GeneratedReceiptsCategoryList(title: 'Band Party', items: controller.bandPartyList, index: 6),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget GeneratedReceiptsCategoryList({
    required String title,
    required List items,
    required int index,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: ExpansionTile(
        controller: expansionControllers[index],
        onExpansionChanged: (value) {
          if (value) {
            for (int i = 0; i < expansionControllers.length; i++) {
              if (i != index && expansionControllers[i].isExpanded) {
                expansionControllers[i].collapse();
              }
            }
          }
        },
        iconColor: AppColors.SECONDARY_COLOR,
        collapsedShape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title:',
              style: TextStyle(
                color: AppColors.SECONDARY_COLOR,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Total: ${items.toList().grandTotal().toDouble().toRupees(symbol: '₹')}',
              style: TextStyle(
                color: AppColors.AMOUNT_COLOR,
                fontWeight: FontWeight.w900,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        children: [
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          if (items.isEmpty) ...[
            Center(
              child: Text(
                'No Data Available',
                style: TextStyle(
                  color: AppColors.SECONDARY_COLOR,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 1.h),
          ] else
            Obx(() {
              return ListView.separated(
                itemCount: items.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h).copyWith(right: 5.w),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await showViewPdfBottomSheet(url: items[index].url!);
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
                                        items[index].amount!.toString().toRupees(),
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
                                      if (items[index].phone != null && items[index].phone != '') {
                                        String contactNo = items[index].phone.toString().replaceAll('+', '').replaceRange(0, 2, '');
                                        String waUrl = 'whatsapp://send?phone=+91$contactNo&text=Your receipt is here👇\n${items[index].url}';
                                        String waWebUrl = 'https://wa.me/+91$contactNo?text=Your receipt is here👇\n${items[index].url}';
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
                                        await Share.share(items[index].url!, subject: 'Share Receipt to person.');
                                      }
                                    }
                                  } else if (value == 'edit') {
                                    controller.amountController.text = items[index].amount ?? '';
                                    controller.nameController.text = items[index].name ?? '';
                                    controller.phoneController.text = items[index].phone ?? '';
                                    if (title == 'Receipt') {
                                      controller.addressController.text = items[index].address ?? '';
                                      controller.isPurposeFundSelected[0] = items[index].type == 'No' ? false : true;
                                      controller.isPurposeFundSelected[1] = items[index].type1 == 'No' ? false : true;
                                      controller.isPurposeFundSelected[2] = items[index].type2 == 'No' ? false : true;
                                      controller.whichCashType[0] = items[index].cash == 'Yes' ? true : false;
                                      controller.whichCashType[1] = items[index].cash == 'No' ? true : false;
                                      controller.chequeNumberController.text = items[index].chequeNumber ?? '';
                                      controller.chequeDateController.text = items[index].chequeDate ?? '';
                                      controller.bankController.text = items[index].bank ?? '';
                                      controller.branchController.text = items[index].branch ?? '';
                                      controller.accountNumberController.text = items[index].accountNumber ?? '';
                                      controller.panNumberController.text = items[index].panNumber ?? '';
                                    }
                                    if (title == 'Niran' || title == 'Gau Dohan') {
                                      controller.quantityController.text = items[index].quantity ?? '';
                                    }
                                    await showEditPdfBottomSheet(
                                      billId: items[index].billId!,
                                      type: title,
                                    );
                                  } else if (value == 'delete') {
                                    await showDeletePdfDialog(billId: items[index].billId!, type: title);
                                  } else if (value == 'view') {
                                    await showViewPdfBottomSheet(url: items[index].url);
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

                                    ///View
                                    PopupMenuItem(
                                      value: 'view',
                                      child: Text(
                                        'View',
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
              );
            }),
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
                            SizedBox(height: 3.h),

                            ///PhoneNumber
                            TextFormField(
                              controller: controller.phoneController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: AppStrings.enterPhoneNumber,
                                hintStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: AppStrings.phoneNumber,
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

                            ///Receipt Extra Fields
                            if (type == 'Receipt') ...[
                              Obx(() {
                                return Column(
                                  children: [
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
                                              onTap: () {},
                                              title: AppStrings.cash,
                                              index: 0,
                                            ),
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
                                          ],
                                        ),
                                      ),
                                    ],

                                    ///PAN Number
                                    TextFormField(
                                      controller: controller.panNumberController,
                                      textInputAction: TextInputAction.done,
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
                                    SizedBox(height: 3.h),
                                  ],
                                );
                              }),
                            ],

                            ///Niran & Gau Dohan Extra Fields
                            if (type == 'Niran' || type == 'Gau Dohan') ...[
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
                              SizedBox(height: 3.h),
                            ],

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

  showDeletePdfDialog({required String billId, required String type}) async {
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
                      await controller.checkDeleteReceipts(billId: billId, type: type);
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

  Future<void> getSearchedList({required String searchedValue}) async {
    if (searchedValue.trim() != "" && searchedValue.isNotEmpty) {
      resetSearchedList();
      controller.receiptList.addAll(
        controller.defaultReceiptList.where((e) {
          return e.name!.toLowerCase().contains(searchedValue.toLowerCase());
        }).toList(),
      );
      controller.niranList.addAll(
        controller.defaultNiranList.where((e) {
          return e.name!.toLowerCase().contains(searchedValue.toLowerCase());
        }).toList(),
      );
      controller.gauDohanList.addAll(
        controller.defaultGauDohanList.where((e) {
          return e.name!.toLowerCase().contains(searchedValue.toLowerCase());
        }).toList(),
      );
      controller.vahanVyavasthaList.addAll(
        controller.defaultVahanVyavasthaList.where((e) {
          return e.name!.toLowerCase().contains(searchedValue.toLowerCase());
        }).toList(),
      );
      controller.sarvarList.addAll(
        controller.defaultSarvarList.where((e) {
          return e.name!.toLowerCase().contains(searchedValue.toLowerCase());
        }).toList(),
      );
      controller.makanBandhkamList.addAll(
        controller.defaultMakanBandhkamList.where((e) {
          return e.name!.toLowerCase().contains(searchedValue.toLowerCase());
        }).toList(),
      );
      controller.bandPartyList.addAll(
        controller.defaultBandPartyList.where((e) {
          return e.name!.toLowerCase().contains(searchedValue.toLowerCase());
        }).toList(),
      );
    } else {
      resetSearchedList();
      controller.receiptList.addAll(controller.defaultReceiptList);
      controller.niranList.addAll(controller.defaultNiranList);
      controller.gauDohanList.addAll(controller.defaultGauDohanList);
      controller.vahanVyavasthaList.addAll(controller.defaultVahanVyavasthaList);
      controller.sarvarList.addAll(controller.defaultSarvarList);
      controller.makanBandhkamList.addAll(controller.defaultMakanBandhkamList);
      controller.bandPartyList.addAll(controller.defaultBandPartyList);
    }
  }

  void resetSearchedList() {
    controller.receiptList.clear();
    controller.niranList.clear();
    controller.gauDohanList.clear();
    controller.vahanVyavasthaList.clear();
    controller.sarvarList.clear();
    controller.makanBandhkamList.clear();
    controller.bandPartyList.clear();
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
