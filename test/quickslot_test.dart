import 'package:flutter_test/flutter_test.dart';
import 'package:quick_slot_app/model/booking_model.dart';
import 'package:quick_slot_app/model/slot_model.dart';
import 'package:quick_slot_app/model/venue_model.dart';
import 'package:quick_slot_app/res/field_validation/field_validation.dart';

void main() {
  group('Field validation', () {
    test('email validation', () {
      expect(AppFieldValidation.validateEmail(''), 'Email is Required');
      expect(AppFieldValidation.validateEmail('bad'), 'Enter Valid Email');
      expect(AppFieldValidation.validateEmail('a@b.com'), '');
    });

    test('password validation', () {
      expect(AppFieldValidation.validatePassword(''), 'Password is Required');
      expect(
        AppFieldValidation.validatePassword('123'),
        'Password must be at least 6 characters',
      );
      expect(AppFieldValidation.validatePassword('123456'), '');
    });

    test('name validation', () {
      expect(AppFieldValidation.validateName(''), 'Name is Required');
      expect(AppFieldValidation.validateName('A'), 'Enter Valid Name');
      expect(AppFieldValidation.validateName('Asha'), '');
    });

    test('confirm password validation', () {
      expect(
        AppFieldValidation.validateConfirmPassword('123456', ''),
        'Confirm your Password',
      );
      expect(
        AppFieldValidation.validateConfirmPassword('123456', 'abcdef'),
        'Passwords do not match',
      );
      expect(
        AppFieldValidation.validateConfirmPassword('123456', '123456'),
        '',
      );
    });
  });

  group('Model parsing', () {
    test('VenueModel.fromJson', () {
      final venue = VenueModel.fromJson({
        'id': 1,
        'name': 'Smash Arena',
        'sport': 'Badminton',
        'location': 'Koramangala',
      });
      expect(venue.id, 1);
      expect(venue.name, 'Smash Arena');
    });

    test('SlotModel booked flag', () {
      final slot = SlotModel.fromJson({
        'id': '1:2026-06-10:6',
        'venueId': 1,
        'date': '2026-06-10',
        'startHour': 6,
        'startTime': '06:00',
        'endTime': '07:00',
        'status': 'booked',
      });
      expect(slot.isBooked, true);
      expect(slot.startTime, '06:00');
    });

    test('BookingModel time range', () {
      final booking = BookingModel.fromJson({
        'id': 10,
        'venue_id': 1,
        'date': '2026-06-10',
        'start_hour': 9,
        'status': 'active',
        'venue_name': 'Smash Arena',
        'sport': 'Badminton',
        'location': 'Koramangala',
      });
      expect(booking.timeRange, '09:00 - 10:00');
      expect(booking.venueName, 'Smash Arena');
    });
  });
}
