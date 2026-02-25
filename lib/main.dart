import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  GoogleMapController? _mapController;
  StreamSubscription<Position>? _positionStream;

  LatLng _currentPosition = const LatLng(30.7333, 76.7794); // Default Chandigarh
  bool _isOnline = false;
  double _speed = 0;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) {

      setState(() {
        _currentPosition =
            LatLng(position.latitude, position.longitude);
        _speed = position.speed * 3.6; // m/s to km/h
      });

      if (_isOnline) {
        FirebaseFirestore.instance.collection('buses').doc('bus_101').set({
          'latitude': position.latitude,
          'longitude': position.longitude,
          'speed': _speed,
          'lastUpdated': FieldValue.serverTimestamp(),
          'status': 'online',
        });
      }

      _mapController?.animateCamera(
        CameraUpdate.newLatLng(_currentPosition),
      );
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  void _toggleOnline() {
    setState(() {
      _isOnline = !_isOnline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// 🔵 GOOGLE MAP
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 16,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: {
              Marker(
                markerId: const MarkerId("bus"),
                position: _currentPosition,
                infoWindow: const InfoWindow(title: "Your Bus"),
              ),
            },
          ),

          /// 🟣 TOP INFO PANEL
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isOnline ? "🟢 Online" : "🔴 Offline",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          _isOnline ? Colors.green : Colors.red,
                    ),
                  ),
                  Text(
                    "Speed: ${_speed.toStringAsFixed(1)} km/h",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔵 BOTTOM CONTROL PANEL
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// ONLINE BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isOnline ? Colors.red : Colors.green,
                        padding:
                            const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _toggleOnline,
                      child: Text(
                        _isOnline
                            ? "Go Offline"
                            : "Go Online",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// EXTRA OPTIONS
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                    children: const [
                      _ActionButton(
                          icon: Icons.history,
                          label: "Trip History"),
                      _ActionButton(
                          icon: Icons.route,
                          label: "Route Info"),
                      _ActionButton(
                          icon: Icons.settings,
                          label: "Settings"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton(
      {required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.indigo.shade50,
          child: Icon(icon, color: Colors.indigo),
        ),
        const SizedBox(height: 5),
        Text(label,
            style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}