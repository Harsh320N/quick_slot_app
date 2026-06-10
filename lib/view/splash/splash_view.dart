import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';
import 'package:quick_slot_app/res/widgets/widget_export.dart';
import 'package:quick_slot_app/view_model/splash/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashViewModel());
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icon/app_icon_foreground.png',
              height: 130.0,
              width: 130.0,
            ),
            verticalSpace(16.0),
            labels(
              text: "Quick Slot",
              color: AppColor.white,
              fontWeight: FontWeight.w700,
              size: 30.0,
            ),
            verticalSpace(6.0),
            labels(
              text: "Book your slot in seconds",
              color: AppColor.white,
              size: 14.0,
            ),
          ],
        ),
      ),
    );
  }
}
