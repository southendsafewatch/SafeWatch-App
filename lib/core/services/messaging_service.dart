import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _messaging.requestPermission();

    // Get FCM token
    final token = await _messaging.getToken();
    print("FCM Token: $token");

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      print("Foreground message: ${message.notification?.title}");
    });
  }
}
