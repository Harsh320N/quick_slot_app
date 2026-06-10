import 'package:quick_slot_app/data/network/network_api_services.dart';
import 'package:quick_slot_app/model/slot_model.dart';
import 'package:quick_slot_app/res/app_url/app_url.dart';

class SlotRepository {
  final NetworkApiServices _api = NetworkApiServices();

  Future<List<SlotModel>> getSlots(int venueId, String date) async {
    final response = await _api.getApi(AppUrl.slots(venueId, date));
    if (response.statusCode == 200 && response.data is Map) {
      final slots = (response.data['slots'] as List?) ?? const [];
      return slots
          .map((e) => SlotModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to load slots');
  }
}
