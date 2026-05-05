import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SosAlertViewer extends StatelessWidget {
  const SosAlertViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "SOS Alerts",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("sos_alerts")
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snap.hasData || snap.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No SOS alerts yet",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            );
          }

          final alerts = snap.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: alerts.length,
            itemBuilder: (context, i) {
              final data = alerts[i].data() as Map<String, dynamic>;

              final lat = data["lat"];
              final lng = data["lng"];
              final active = data["active"] == true;
              final ts = data["timestamp"] as Timestamp?;
              final time = ts != null
                  ? DateFormat("dd MMM yyyy • HH:mm").format(ts.toDate())
                  : "Unknown";

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: active ? Colors.red : Colors.grey,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          active ? "ACTIVE SOS" : "Resolved",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: active ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Location: $lat, $lng",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Time: $time",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
