import 'package:get/get.dart';
import 'package:quick_slot_app/data/session/session.dart';
import 'package:quick_slot_app/repository/auth_repository.dart';
import 'package:quick_slot_app/res/routes/route_name.dart';

class SplashViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  @override
  void onReady() {
    super.onReady();
    _decideStartScreen();
  }

  Future<void> _decideStartScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    final user = _authRepository.currentUser;
    if (user != null) {
      Session.set(user.uid, user.displayName ?? 'Player');
      Get.offAllNamed(RouteName.venueList);
    } else {
      Get.offAllNamed(RouteName.login);
    }
  }
}
