import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _users = FirebaseFirestore.instance.collection("users");

  Stream<QuerySnapshot> streamAllSharedUsers() {
    return _users.where("shareLocation", isEqualTo: true).snapshots();
  }

  Future<void> updateUserLocation(String uid, double lat, double lng) async {
    await _users.doc(uid).update({
      "lat": lat,
      "lng": lng,
      "updated": FieldValue.serverTimestamp(),
    });
  }
}
