import 'package:quick_slot_app/data/app_preference/app_preference.dart';
import 'package:quick_slot_app/res/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick_slot_app/res/app_them/app_theme.dart';
import 'package:quick_slot_app/res/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //TODO: INIT CUSTOM SHARED PREFERENCE CLASS
  AppPreference.init();

  //TODO: GET SHARED PREFERENCE
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //TODO: DISABLE HORIZONTAL VIEW OF APPLICATION
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppPreferenceData.getTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      builder: (context, child) {
        return ScrollConfiguration(behavior: MyBehavior(), child: child!);
      },
    );
  }
}

//TODO: DISABLE SCROLLING GLOW OF SYSTEM
class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
