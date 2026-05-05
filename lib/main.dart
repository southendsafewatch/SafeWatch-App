import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SafeWatchApp());
}

class SafeWatchApp extends StatelessWidget {
  const SafeWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SafeWatch",
      debugShowCheckedModeBanner: false,

      // Start at AuthGate
      initialRoute: "/auth",

      // Use your AppRouter for all navigation
      onGenerateRoute: AppRouter.generateRoute,

      // Global dark theme
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1F1F1F),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}
