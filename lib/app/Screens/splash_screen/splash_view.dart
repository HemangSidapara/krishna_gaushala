import 'package:flutter/material.dart';
import 'package:krishna_gaushala/app/Constants/app_colors.dart';
import 'package:krishna_gaushala/app/Utils/app_sizer.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setSize(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      body: Center(
        child: Container(
          color: Colors.red,
          child: SizedBox(
            height: 50.h,
            width: 50.w,
          ),
        ),
      ),
    );
  }
}
