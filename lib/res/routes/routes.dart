import 'package:get/get.dart';
import 'package:quick_slot_app/res/routes/route_name.dart';
import 'package:quick_slot_app/view/auth/login_view.dart';
import 'package:quick_slot_app/view/auth/register_view.dart';
import 'package:quick_slot_app/view/splash/splash_view.dart';

class AppRoute {
  static List<GetPage> pages = [
    GetPage(name: RouteName.splash, page: () => const SplashView()),
    GetPage(name: RouteName.login, page: () => const LoginView()),
    GetPage(name: RouteName.register, page: () => const RegisterView()),
  ];
}
