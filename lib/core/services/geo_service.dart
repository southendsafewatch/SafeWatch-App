import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class GeoService {
  GeoService._internal();
  static final GeoService instance = GeoService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _locations =>
      _firestore.collection('locations');

  String? get uid => _auth.currentUser?.uid;

  Future<void> updateUserLocation(Position pos) async {
    if (uid == null) return;

    await _locations.doc(uid).set({
      'uid': uid,
      'lat': pos.latitude,
      'lng': pos.longitude,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllLocations() {
    return _locations.snapshots();
  }
}
