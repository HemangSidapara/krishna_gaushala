import 'package:flutter/material.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Constants/app_images.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setSize(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: Center(
        child: Image.asset(
          Images.splashImage,
          height: 70.w,
          width: 70.w,
        ),
      ),
    );
  }
}
