import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? controller;
  final Set<Marker> _markers = {};

  void _openDetails(BuildContext context, String id, Map<String, dynamic> data) {
    final lat = data["lat"];
    final lng = data["lng"];
    final active = data["active"] == true;
    final ts = data["timestamp"] as Timestamp?;
    final time = ts != null
        ? DateFormat("dd MMM yyyy • HH:mm").format(ts.toDate())
        : "Unknown";

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: active ? Colors.red : Colors.grey,
                    size: 32,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    active ? "ACTIVE SOS" : "Resolved",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: active ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Text("Location: $lat, $lng",
                  style: const TextStyle(fontSize: 18)),

              const SizedBox(height: 10),

              Text("Time: $time",
                  style: const TextStyle(fontSize: 16, color: Colors.black54)),

              const SizedBox(height: 30),

              if (active)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("sos_alerts")
                          .doc(id)
                          .update({"active": false});

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Mark as Resolved",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _updateMarkers(QuerySnapshot snap) {
    final newMarkers = <Marker>{};

    for (var doc in snap.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final lat = data["lat"];
      final lng = data["lng"];
      final active = data["active"] == true;

      if (lat != null && lng != null) {
        newMarkers.add(
          Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(lat, lng),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              active ? BitmapDescriptor.hueRed : BitmapDescriptor.hueAzure,
            ),
            onTap: () => _openDetails(context, doc.id, data),
          ),
        );
      }
    }

    setState(() {
      _markers
        ..clear()
        ..addAll(newMarkers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Live Map",
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
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // SAFE: update markers after build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _updateMarkers(snap.data!);
            }
          });

          return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(51.5074, 0.1278),
              zoom: 12,
            ),
            markers: _markers,
            onMapCreated: (c) => controller = c,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
          );
        },
      ),
    );
  }
}
