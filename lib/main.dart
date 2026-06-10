import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quick_slot_app/data/app_preference/app_preference.dart';
import 'package:quick_slot_app/res/app_them/app_theme.dart';
import 'package:quick_slot_app/res/routes/route_name.dart';
import 'package:quick_slot_app/res/routes/routes.dart';
import 'package:quick_slot_app/utils/screen_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppPreference.init();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppPreferenceData.getTheme();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quick Slot",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: RouteName.splash,
      getPages: AppRoute.pages,
      builder: (context, child) {
        Screen.setScreenSize(context);
        return ScrollConfiguration(behavior: MyBehavior(), child: child!);
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
