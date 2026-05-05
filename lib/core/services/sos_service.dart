import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SosService {
  SosService._internal();
  static final SosService instance = SosService._internal();

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _alerts =>
      _firestore.collection("sos_alerts");

  Future<void> triggerSOS(double lat, double lng) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _alerts.add({
      "uid": uid,
      "lat": lat,
      "lng": lng,
      "timestamp": FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAlerts() {
    return _alerts.orderBy("timestamp", descending: true).snapshots();
  }
}
