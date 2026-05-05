import 'package:flutter/material.dart';
import '../../core/services/location_service.dart';
import '../../core/services/firestore_service.dart';
import '../../core/constants.dart';
import '../../widgets/primary_button.dart';

class PatrolScreen extends StatefulWidget {
  const PatrolScreen({super.key});

  @override
  State<PatrolScreen> createState() => _PatrolScreenState();
}

class _PatrolScreenState extends State<PatrolScreen> {
  final _location = LocationService();
  final _firestore = FirestoreService();

  bool _onDuty = false;
  bool _loading = false;
  String? _message;

  Future<void> _togglePatrol() async {
    setState(() {
      _loading = true;
      _message = null;
    });

    final pos = await _location.getCurrentLocation();
    if (pos == null) {
      setState(() {
        _loading = false;
        _message = "Location permission denied.";
      });
      return;
    }

    _onDuty = !_onDuty;

    await _firestore.setDocument(
      collection: AppConstants.patrolStatusCollection,
      docId: "TEMP_USER", // replace with real user ID later
      data: {
        "userId": "TEMP_USER",
        "onDuty": _onDuty,
        "lat": pos.latitude,
        "lng": pos.longitude,
        "updatedAt": DateTime.now().toIso8601String(),
      },
    );

    setState(() {
      _loading = false;
      _message = _onDuty ? "You are now ON DUTY" : "You are now OFF DUTY";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patrol Mode")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Icon(
              _onDuty ? Icons.shield : Icons.shield_outlined,
              size: 120,
              color: _onDuty ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 20),

            Text(
              _onDuty ? "You are currently patrolling" : "You are off duty",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            const Text(
              "Patrol volunteers help keep the community safe by being visible and reporting issues.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 40),

            if (_message != null)
              Text(
                _message!,
                style: TextStyle(
                  color: _onDuty ? Colors.green : Colors.red,
                  fontSize: 16,
                ),
              ),

            const Spacer(),

            _loading
                ? const CircularProgressIndicator()
                : PrimaryButton(
                    label: _onDuty ? "Stop Patrol" : "Start Patrol",
                    icon: _onDuty ? Icons.stop : Icons.play_arrow,
                    color: _onDuty ? Colors.red : Colors.green,
                    onPressed: _togglePatrol,
                  ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
