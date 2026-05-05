import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  bool sending = false;

  Future<void> _triggerSOS() async {
    setState(() => sending = true);

    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await FirebaseFirestore.instance.collection("sos_alerts").add({
        "lat": pos.latitude,
        "lng": pos.longitude,
        "active": true,
        "timestamp": DateTime.now(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("SOS alert sent"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
            backgroundColor: Colors.black87,
          ),
        );
      }
    }

    if (mounted) setState(() => sending = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND GRADIENT
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1F1F1F), Color(0xFF3A3A3A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // TOP GLASS HEADER
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          size: 28, color: Colors.black87),
                      const SizedBox(width: 12),
                      const Text(
                        "SOS Alert",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close, size: 26),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // MAIN CONTENT
          Positioned.fill(
            top: 140,
            child: Column(
              children: [
                const Text(
                  "Emergency Assistance",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Press the button below to send an SOS alert\nwith your live location.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 60),

                // SOS BUTTON
                GestureDetector(
                  onTap: sending ? null : _triggerSOS,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: sending ? Colors.red.shade300 : Colors.red,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.5),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: sending
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 4,
                            )
                          : const Text(
                              "SOS",
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // RECENT ALERTS LIST
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("sos_alerts")
                          .orderBy("timestamp", descending: true)
                          .snapshots(),
                      builder: (context, snap) {
                        if (!snap.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          );
                        }

                        final alerts = snap.data!.docs;

                        if (alerts.isEmpty) {
                          return const Center(
                            child: Text(
                              "No alerts yet",
                              style: TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: alerts.length,
                          itemBuilder: (context, i) {
                            final data = alerts[i].data() as Map<String, dynamic>;
                            final active = data["active"] == true;
                            final ts = data["timestamp"] as Timestamp?;
                            final time = ts != null
                                ? DateFormat("dd MMM • HH:mm").format(ts.toDate())
                                : "Unknown";

                            return Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: active ? Colors.red : Colors.grey,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      active
                                          ? "Active SOS • $time"
                                          : "Resolved • $time",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
