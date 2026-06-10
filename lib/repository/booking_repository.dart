import 'package:quick_slot_app/data/network/network_api_services.dart';
import 'package:quick_slot_app/res/app_url/app_url.dart';

enum BookingStatus { success, alreadyBooked, invalid, venueNotFound, failed }

class BookingResult {
  final BookingStatus status;
  final String message;

  BookingResult(this.status, this.message);
}

class BookingRepository {
  final NetworkApiServices _api = NetworkApiServices();

  Future<BookingResult> book({
    required int venueId,
    required String date,
    required int startHour,
  }) async {
    final response = await _api.postApi(
      {'venueId': venueId, 'date': date, 'startHour': startHour},
      AppUrl.bookings,
    );
    switch (response.statusCode) {
      case 201:
        return BookingResult(BookingStatus.success, 'Slot booked successfully.');
      case 409:
        return BookingResult(
          BookingStatus.alreadyBooked,
          'Sorry, that slot was just taken. Please pick another.',
        );
      case 400:
        return BookingResult(
          BookingStatus.invalid,
          _serverMessage(response.data) ?? 'Invalid booking request.',
        );
      case 404:
        return BookingResult(BookingStatus.venueNotFound, 'Venue not found.');
      default:
        return BookingResult(
          BookingStatus.failed,
          'Could not complete the booking. Please try again.',
        );
    }
  }

  String? _serverMessage(dynamic data) {
    if (data is Map && data['error'] is String) {
      return data['error'] as String;
    }
    return null;
  }
}
