import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Localization/en_IN.dart';
import 'package:krishna_gaushala/app/Localization/gu_IN.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en_IN': enIN,
      'gu_IN': guIN,
    };
  }
}
