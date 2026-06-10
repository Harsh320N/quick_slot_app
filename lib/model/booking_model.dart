class BookingModel {
  final int id;
  final int venueId;
  final String date;
  final int startHour;
  final String status;
  final String venueName;
  final String sport;
  final String location;

  BookingModel({
    required this.id,
    required this.venueId,
    required this.date,
    required this.startHour,
    required this.status,
    required this.venueName,
    required this.sport,
    required this.location,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'] as int,
        venueId: (json['venue_id'] ?? 0) as int,
        date: (json['date'] ?? '') as String,
        startHour: (json['start_hour'] ?? 0) as int,
        status: (json['status'] ?? '') as String,
        venueName: (json['venue_name'] ?? '') as String,
        sport: (json['sport'] ?? '') as String,
        location: (json['location'] ?? '') as String,
      );

  String get timeRange {
    String two(int hour) => hour.toString().padLeft(2, '0');
    return '${two(startHour)}:00 - ${two(startHour + 1)}:00';
  }
}
