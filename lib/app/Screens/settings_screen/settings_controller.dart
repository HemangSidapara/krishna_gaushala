import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Constants/app_icons.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';

class SettingsController extends GetxController {
  List<String> settingsNameList = [
    AppStrings.costDetails,
    AppStrings.generatedReceipts,
  ];

  List<String> settingsIconList = [
    AppIcons.sendMoneyIcon,
    AppIcons.invoiceIcon,
  ];
}
