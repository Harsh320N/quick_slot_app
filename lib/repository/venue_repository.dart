import 'package:quick_slot_app/data/network/network_api_services.dart';
import 'package:quick_slot_app/model/venue_model.dart';
import 'package:quick_slot_app/res/app_url/app_url.dart';

class VenueRepository {
  final NetworkApiServices _api = NetworkApiServices();

  Future<List<VenueModel>> getVenues() async {
    final response = await _api.getApi(AppUrl.venues);
    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .map((e) => VenueModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to load venues');
  }
}
