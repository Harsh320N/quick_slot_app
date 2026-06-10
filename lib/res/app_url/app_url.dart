import 'dart:io';

class AppUrl {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://localhost:3000';
  }

  static String get venues => '$baseUrl/venues';

  static String slots(int venueId, String date) =>
      '$baseUrl/venues/$venueId/slots?date=$date';

  static String get bookings => '$baseUrl/bookings';

  static String userBookings(String userId) =>
      '$baseUrl/users/$userId/bookings';

  static String cancelBooking(int bookingId) => '$baseUrl/bookings/$bookingId';
}
