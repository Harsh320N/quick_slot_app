import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quick_slot_app/data/response/api_response.dart';
import 'package:quick_slot_app/model/slot_model.dart';
import 'package:quick_slot_app/model/venue_model.dart';
import 'package:quick_slot_app/repository/booking_repository.dart';
import 'package:quick_slot_app/repository/slot_repository.dart';
import 'package:quick_slot_app/utils/utils.dart';

class VenueDetailViewModel extends GetxController {
  final SlotRepository _slotRepository = SlotRepository();
  final BookingRepository _bookingRepository = BookingRepository();
  final VenueModel venue;

  VenueDetailViewModel(this.venue);

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<ApiResponse<List<SlotModel>>> slots =
      ApiResponse<List<SlotModel>>.loading().obs;
  final RxnInt bookingHour = RxnInt();

  DateTime get _todayDate {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  String get apiDate => DateFormat('yyyy-MM-dd').format(selectedDate.value);

  String get displayDate =>
      DateFormat('EEE, dd MMM yyyy').format(selectedDate.value);

  bool get canGoPrev => selectedDate.value.isAfter(_todayDate);

  @override
  void onInit() {
    super.onInit();
    selectedDate.value = _todayDate;
    fetchSlots();
  }

  Future<void> fetchSlots() async {
    slots.value = ApiResponse.loading();
    try {
      final data = await _slotRepository.getSlots(venue.id, apiDate);
      slots.value = ApiResponse.completed(data);
    } catch (_) {
      slots.value = ApiResponse.error('Could not load slots. Please retry.');
    }
  }

  void setDate(DateTime date) {
    selectedDate.value = DateTime(date.year, date.month, date.day);
    fetchSlots();
  }

  void prevDay() {
    if (!canGoPrev) return;
    setDate(selectedDate.value.subtract(const Duration(days: 1)));
  }

  void nextDay() => setDate(selectedDate.value.add(const Duration(days: 1)));

  Future<void> book(SlotModel slot) async {
    if (bookingHour.value != null || slot.isBooked) return;
    bookingHour.value = slot.startHour;
    try {
      final result = await _bookingRepository.book(
        venueId: venue.id,
        date: apiDate,
        startHour: slot.startHour,
      );
      Utils.snack(text: result.message);
      if (result.status == BookingStatus.success ||
          result.status == BookingStatus.alreadyBooked) {
        await fetchSlots();
      }
    } catch (_) {
      Utils.snack(text: 'Could not complete the booking. Please try again.');
    } finally {
      bookingHour.value = null;
    }
  }
}

