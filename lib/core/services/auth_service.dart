import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Stream<User?> get userStream => _auth.authStateChanges();

  Future<User?> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<User?> register(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<void> saveUserRole(String uid, String role) async {
    await _db.collection("users").doc(uid).set({
      "role": role,
    }, SetOptions(merge: true));
  }

  Future<String?> getUserRole(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    if (doc.exists && doc.data()!.containsKey("role")) {
      return doc["role"];
    }
    return null;
  }

  Future<void> logout() async => _auth.signOut();
}
