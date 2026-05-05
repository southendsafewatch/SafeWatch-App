import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_service.dart';

class LocationService {
  final _firestore = FirestoreService();

  Future<void> updateLocation() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    await _firestore.updateUserLocation(
      user.uid,
      pos.latitude,
      pos.longitude,
    );
  }
}
