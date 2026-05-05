import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/constants.dart';
import '../../core/services/location_service.dart';
import '../../widgets/primary_button.dart';

class SafeRouteScreen extends StatefulWidget {
  const SafeRouteScreen({super.key});

  @override
  State<SafeRouteScreen> createState() => _SafeRouteScreenState();
}

class _SafeRouteScreenState extends State<SafeRouteScreen> {
  GoogleMapController? _controller;
  final _location = LocationService();

  LatLng? _start;
  LatLng? _end;

  bool _loading = false;
  String? _message;

  Future<void> _setStart() async {
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

    setState(() {
      _start = LatLng(pos.latitude, pos.longitude);
      _loading = false;
      _message = "Start point set.";
    });
  }

  Future<void> _setEnd() async {
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

    setState(() {
      _end = LatLng(pos.latitude, pos.longitude);
      _loading = false;
      _message = "Destination set.";
    });
  }

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>{};

    if (_start != null) {
      markers.add(
        Marker(
          markerId: const MarkerId("start"),
          position: _start!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }

    if (_end != null) {
      markers.add(
        Marker(
          markerId: const MarkerId("end"),
          position: _end!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Safe Route")),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(AppConstants.defaultLat, AppConstants.defaultLng),
                zoom: 13,
              ),
              onMapCreated: (c) => _controller = c,
              markers: markers,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),

          if (_message != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                _message!,
                style: TextStyle(
                  color: _message!.contains("set") ? Colors.green : Colors.red,
                  fontSize: 16,
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _loading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                        label: "Set Start Point",
                        icon: Icons.flag,
                        onPressed: _setStart,
                      ),
                const SizedBox(height: 12),
                _loading
                    ? const SizedBox()
                    : PrimaryButton(
                        label: "Set Destination",
                        icon: Icons.location_on,
                        onPressed: _setEnd,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
