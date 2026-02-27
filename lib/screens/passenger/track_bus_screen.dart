import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrackBusScreen extends StatefulWidget {
  const TrackBusScreen({super.key});

  @override
  State<TrackBusScreen> createState() => _TrackBusScreenState();
}

class _TrackBusScreenState extends State<TrackBusScreen> {
  LatLng _busLocation = const LatLng(31.3260, 75.5762);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Bus')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('buses').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final data =
                snapshot.data!.docs.first.data() as Map<String, dynamic>;
            if (data['latitude'] != null && data['longitude'] != null) {
              _busLocation = LatLng(
                (data['latitude'] as num).toDouble(),
                (data['longitude'] as num).toDouble(),
              );
            }
          }
          return Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter: _busLocation,
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'bus_tracking_system',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _busLocation,
                        width: 60,
                        height: 60,
                        child: const Icon(
                          Icons.directions_bus_rounded,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        const Icon(Icons.directions_bus_rounded,
                            color: Colors.red, size: 32),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Bus PB08-101',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Text(
                                'Lat: ${_busLocation.latitude.toStringAsFixed(4)}  '
                                'Lng: ${_busLocation.longitude.toStringAsFixed(4)}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('Live',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
