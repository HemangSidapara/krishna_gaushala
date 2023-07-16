import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_strings.dart';
import 'package:krishna_gaushala/app/Localization/localization.dart';
import 'package:krishna_gaushala/app/Routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      translations: Localization(),
      locale: const Locale('gu', 'IN'),
      fallbackLocale: const Locale('en', 'IN'),
      theme: ThemeData(
        primaryColor: AppColors.PRIMARY_COLOR,
        textTheme: GoogleFonts.nunitoSansTextTheme(),
        datePickerTheme: DatePickerThemeData(headerBackgroundColor: AppColors.SECONDARY_COLOR),
      ),
      initialRoute: Routes.splash,
      defaultTransition: Transition.downToUp,
      getPages: AppPages.pages,
    );
  }
}
