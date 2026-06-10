import 'package:get/get.dart';
import 'package:quick_slot_app/data/session/session.dart';
import 'package:quick_slot_app/repository/auth_repository.dart';
import 'package:quick_slot_app/res/routes/route_name.dart';

class VenueListViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  Future<void> logout() async {
    await _authRepository.logout();
    Session.clear();
    Get.offAllNamed(RouteName.login);
  }
}
