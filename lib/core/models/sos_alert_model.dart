class SosAlert {
  final String id;
  final String uid;
  final double lat;
  final double lng;
  final DateTime timestamp;

  SosAlert({
    required this.id,
    required this.uid,
    required this.lat,
    required this.lng,
    required this.timestamp,
  });

  factory SosAlert.fromMap(String id, Map<String, dynamic> data) {
    return SosAlert(
      id: id,
      uid: data['uid'],
      lat: (data['lat'] ?? 0).toDouble(),
      lng: (data['lng'] ?? 0).toDouble(),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
