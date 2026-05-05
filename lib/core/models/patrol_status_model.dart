class PatrolStatusModel {
  final String userId;
  final bool onDuty;
  final double? lat;
  final double? lng;
  final DateTime updatedAt;

  PatrolStatusModel({
    required this.userId,
    required this.onDuty,
    this.lat,
    this.lng,
    required this.updatedAt,
  });

  factory PatrolStatusModel.fromMap(Map<String, dynamic> data) {
    return PatrolStatusModel(
      userId: data['userId'],
      onDuty: data['onDuty'] ?? false,
      lat: (data['lat'] as num?)?.toDouble(),
      lng: (data['lng'] as num?)?.toDouble(),
      updatedAt: DateTime.parse(data['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'onDuty': onDuty,
      'lat': lat,
      'lng': lng,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
