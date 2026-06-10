import 'package:quick_slot_app/data/network/network_api_services.dart';
import 'package:quick_slot_app/model/booking_model.dart';
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

  Future<List<BookingModel>> getUserBookings(String userId) async {
    final response = await _api.getApi(AppUrl.userBookings(userId));
    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to load bookings');
  }

  Future<bool> cancelBooking(int bookingId) async {
    final response = await _api.deleteApi(null, AppUrl.cancelBooking(bookingId));
    return response.statusCode == 204 || response.statusCode == 200;
  }

  String? _serverMessage(dynamic data) {
    if (data is Map && data['error'] is String) {
      return data['error'] as String;
    }
    return null;
  }
}
