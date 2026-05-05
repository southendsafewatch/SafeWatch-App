class UserModel {
  final String uid;
  final String email;
  final String role; // Parent / Teen / Patrol Volunteer
  final String? displayName;
  final double? lat;
  final double? lng;
  final bool isActivePatrol; // for volunteers

  UserModel({
    required this.uid,
    required this.email,
    required this.role,
    this.displayName,
    this.lat,
    this.lng,
    this.isActivePatrol = false,
  });

  // Convert Firestore → Model
  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      role: data['role'] ?? 'Teen',
      displayName: data['displayName'],
      lat: (data['lat'] as num?)?.toDouble(),
      lng: (data['lng'] as num?)?.toDouble(),
      isActivePatrol: data['isActivePatrol'] ?? false,
    );
  }

  // Convert Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role,
      'displayName': displayName,
      'lat': lat,
      'lng': lng,
      'isActivePatrol': isActivePatrol,
    };
  }
}
