import 'package:get/get.dart';
import 'package:quick_slot_app/data/response/api_response.dart';
import 'package:quick_slot_app/data/session/session.dart';
import 'package:quick_slot_app/model/booking_model.dart';
import 'package:quick_slot_app/repository/booking_repository.dart';
import 'package:quick_slot_app/utils/utils.dart';

class MyBookingsViewModel extends GetxController {
  final BookingRepository _bookingRepository = BookingRepository();

  final Rx<ApiResponse<List<BookingModel>>> bookings =
      ApiResponse<List<BookingModel>>.loading().obs;
  final RxnInt cancellingId = RxnInt();

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    final userId = Session.userId;
    if (userId == null) {
      bookings.value = ApiResponse.error('You are not signed in.');
      return;
    }
    bookings.value = ApiResponse.loading();
    try {
      final data = await _bookingRepository.getUserBookings(userId);
      bookings.value = ApiResponse.completed(data);
    } catch (_) {
      bookings.value =
          ApiResponse.error('Could not load your bookings. Please retry.');
    }
  }

  Future<void> cancel(BookingModel booking) async {
    if (cancellingId.value != null) return;
    cancellingId.value = booking.id;
    try {
      final cancelled = await _bookingRepository.cancelBooking(booking.id);
      if (cancelled) {
        Utils.snack(text: 'Booking cancelled.');
        await fetchBookings();
      } else {
        Utils.snack(text: 'Could not cancel this booking.');
      }
    } catch (_) {
      Utils.snack(text: 'Could not cancel booking. Please try again.');
    } finally {
      cancellingId.value = null;
    }
  }
}
