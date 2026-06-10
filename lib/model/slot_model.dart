class SlotModel {
  final String id;
  final int venueId;
  final String date;
  final int startHour;
  final String startTime;
  final String endTime;
  final String status;

  SlotModel({
    required this.id,
    required this.venueId,
    required this.date,
    required this.startHour,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  bool get isBooked => status == 'booked';

  factory SlotModel.fromJson(Map<String, dynamic> json) => SlotModel(
        id: (json['id'] ?? '') as String,
        venueId: json['venueId'] as int,
        date: (json['date'] ?? '') as String,
        startHour: json['startHour'] as int,
        startTime: (json['startTime'] ?? '') as String,
        endTime: (json['endTime'] ?? '') as String,
        status: (json['status'] ?? 'available') as String,
      );
}
