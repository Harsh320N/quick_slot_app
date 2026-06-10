import 'package:get/get.dart';
import 'package:quick_slot_app/res/routes/route_name.dart';

class SplashViewModel extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(RouteName.login);
  }
}
