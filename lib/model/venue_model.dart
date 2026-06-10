class VenueModel {
  final int id;
  final String name;
  final String sport;
  final String location;

  VenueModel({
    required this.id,
    required this.name,
    required this.sport,
    required this.location,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) => VenueModel(
        id: json['id'] as int,
        name: (json['name'] ?? '') as String,
        sport: (json['sport'] ?? '') as String,
        location: (json['location'] ?? '') as String,
      );
}
