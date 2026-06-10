import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:quick_slot_app/res/widgets/widget_export.dart';
import 'package:get/get.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';

class Utils {
  //TODO: FIELD FOCUS
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //TODO: DISPOSE KEYBOARD
  static void disposeKeyboard() {
    return FocusManager.instance.primaryFocus?.unfocus();
  }

  //TODO: INTERNET CONNECTION
  static checkConnection() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    return (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi));
  }

  // //TODO: OPEN URL
  // static Future<void> openUrl(Uri link) async {
  //   if (!await launchUrl(link)) {
  //     throw 'Could not launch $link';
  //   }
  // }
  //
  // //TODO: OPEN APP
  // static Future<void> openApp(Uri url) async {
  //   if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
  //     throw 'Could not launch $url';
  //   }
  // }
  //
  // //TODO: SHARE LINK
  // static void onShare({String text = ""}) async {
  //   await Share.share(text);
  // }

  //TODO: APP LOADER
  static Widget loader() => const CircularProgressIndicator();

  //TODO: APP SNACK BAR
  static snack({
    required String text,
    IconData? icon,
  }) =>
      Get.showSnackbar(
        GetSnackBar(
          messageText: listTile(
            leading: Icon(
              icon,
              color: Get.isDarkMode ? AppColor.white : AppColor.black,
              size: 24.0,
            ),
            title: labels(
              text: text,
              color: AppColor.white,
              maxLine: 5,
              size: 10.0,
              wordSpacing: 0.5,
              letterSpacing: 0.5,
            ),
            spaceLeadingTitle: 5.0,
            spaceTitleSubTitle: 0,
          ),
          duration: const Duration(seconds: 2),
          animationDuration: const Duration(milliseconds: 350),
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          borderRadius: 5.0,
        ),
      );
}
