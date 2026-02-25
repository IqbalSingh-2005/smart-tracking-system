import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PassengerScreen extends StatefulWidget {
  const PassengerScreen({super.key});

  @override
  State<PassengerScreen> createState() => _PassengerScreenState();
}

class _PassengerScreenState extends State<PassengerScreen> {
  GoogleMapController? _mapController;
  BitmapDescriptor? _busIcon;

  LatLng? _busLocation;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadBusIcon();
    _listenToBus();
  }

  // 🔥 Load custom bus icon
  Future<void> _loadBusIcon() async {
    _busIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/bus.png',
    );
  }

  // 🔥 Listen to Firestore updates
  void _listenToBus() {
    FirebaseFirestore.instance
        .collection("buses")
        .doc("bus_101")
        .snapshots()
        .listen((snapshot) {
      if (!snapshot.exists) return;

      var data = snapshot.data() as Map<String, dynamic>;

      double lat = (data["latitude"] ?? 0).toDouble();
      double lng = (data["longitude"] ?? 0).toDouble();

      if (lat == 0 && lng == 0) return;

      LatLng newPosition = LatLng(lat, lng);

      setState(() {
        _busLocation = newPosition;

        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId("bus"),
            position: _busLocation!,
            icon: _busIcon ?? BitmapDescriptor.defaultMarker,
            anchor: const Offset(0.5, 0.5),
            flat: true,
            infoWindow: const InfoWindow(title: "Bus 101"),
          ),
        );
      });

      // 🔥 Smooth camera follow
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(_busLocation!, 16),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_busLocation == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Live Bus Tracking")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _busLocation!,
          zoom: 16,
        ),
        markers: _markers,
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
    );
  }
}