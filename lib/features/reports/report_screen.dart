import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/services/firestore_service.dart';
import '../../core/services/location_service.dart';
import '../../widgets/primary_button.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _firestore = FirestoreService();
  final _location = LocationService();

  String _selectedType = AppConstants.reportTypes.first;
  final _descriptionController = TextEditingController();

  bool _loading = false;
  String? _message;

  Future<void> _submitReport() async {
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

    final id = DateTime.now().millisecondsSinceEpoch.toString();

    await _firestore.setDocument(
      collection: AppConstants.reportsCollection,
      docId: id,
      data: {
        "userId": "TEMP_USER", // will replace with real user later
        "type": _selectedType,
        "description": _descriptionController.text.trim(),
        "lat": pos.latitude,
        "lng": pos.longitude,
        "timestamp": DateTime.now().toIso8601String(),
      },
    );

    setState(() {
      _loading = false;
      _message = "Report submitted successfully.";
      _descriptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Submit Report")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Report an Issue",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const Text("Type of Issue"),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: _selectedType,
              items: AppConstants.reportTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedType = v!),
              decoration: const InputDecoration(
                filled: true,
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text("Description"),
            const SizedBox(height: 8),

            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Describe what happened...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            if (_message != null)
              Text(
                _message!,
                style: TextStyle(
                  color: _message!.contains("success")
                      ? Colors.green
                      : Colors.red,
                ),
              ),

            const SizedBox(height: 20),

            _loading
                ? const Center(child: CircularProgressIndicator())
                : PrimaryButton(
                    label: "Submit Report",
                    icon: Icons.send,
                    onPressed: _submitReport,
                  ),
          ],
        ),
      ),
    );
  }
}
