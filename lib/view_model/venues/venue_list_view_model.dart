import 'package:get/get.dart';
import 'package:quick_slot_app/data/response/api_response.dart';
import 'package:quick_slot_app/data/session/session.dart';
import 'package:quick_slot_app/model/venue_model.dart';
import 'package:quick_slot_app/repository/auth_repository.dart';
import 'package:quick_slot_app/repository/venue_repository.dart';
import 'package:quick_slot_app/res/routes/route_name.dart';

class VenueListViewModel extends GetxController {
  final VenueRepository _venueRepository = VenueRepository();
  final AuthRepository _authRepository = AuthRepository();

  final Rx<ApiResponse<List<VenueModel>>> venues =
      ApiResponse<List<VenueModel>>.loading().obs;

  @override
  void onInit() {
    super.onInit();
    fetchVenues();
  }

  Future<void> fetchVenues() async {
    venues.value = ApiResponse.loading();
    try {
      final data = await _venueRepository.getVenues();
      venues.value = ApiResponse.completed(data);
    } catch (_) {
      venues.value = ApiResponse.error('Could not load venues. Please retry.');
    }
  }

  String get greeting => 'Hi, ${Session.userName ?? 'Player'}';

  void openVenue(VenueModel venue) =>
      Get.toNamed(RouteName.venueDetail, arguments: venue);

  void openMyBookings() => Get.toNamed(RouteName.myBookings);

  Future<void> logout() async {
    await _authRepository.logout();
    Session.clear();
    Get.offAllNamed(RouteName.login);
  }
}
