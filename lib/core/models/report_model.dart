class ReportModel {
  final String id;
  final String userId;
  final String type; // e.g. "Fight", "Weapon sighting"
  final String description;
  final double lat;
  final double lng;
  final DateTime timestamp;

  ReportModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.description,
    required this.lat,
    required this.lng,
    required this.timestamp,
  });

  factory ReportModel.fromMap(Map<String, dynamic> data, String id) {
    return ReportModel(
      id: id,
      userId: data['userId'],
      type: data['type'],
      description: data['description'],
      lat: (data['lat'] as num).toDouble(),
      lng: (data['lng'] as num).toDouble(),
      timestamp: DateTime.parse(data['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type,
      'description': description,
      'lat': lat,
      'lng': lng,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
