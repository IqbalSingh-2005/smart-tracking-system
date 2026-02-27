import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'driver/nearby_drivers_screen.dart';
import 'driver/settings_screen.dart';
import 'driver/trips_screen.dart';
import 'driver/bus_status_screen.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  LatLng _location = const LatLng(31.3260, 75.5762);
  bool _tracking = false;
  int _passengers = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Panel'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const NearbyDriversScreen()),
            ),
            icon: const Icon(Icons.people_alt_rounded),
            tooltip: 'Nearby Drivers',
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TripsScreen()),
            ),
            icon: const Icon(Icons.route_rounded),
            tooltip: 'Trip History',
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BusStatusScreen()),
            ),
            icon: const Icon(Icons.monitor_heart_rounded),
            tooltip: 'Bus Status',
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/help'),
            icon: const Icon(Icons.help_outline_rounded),
            tooltip: 'Help',
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
            icon: const Icon(Icons.settings_rounded),
            tooltip: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('🚨 SOS Sent!'))),
        icon: const Icon(Icons.warning_amber_rounded),
        label: const Text('SOS'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _location,
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
                      point: _location,
                      width: 60,
                      height: 60,
                      child: Icon(
                        Icons.directions_bus_rounded,
                        size: 40,
                        color: _tracking ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _infoCard(
                        'Bus No',
                        'PB08-101',
                        Icons.directions_bus_rounded,
                        Colors.indigo,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _infoCard(
                        'Status',
                        _tracking ? 'Running' : 'Stopped',
                        _tracking
                            ? Icons.play_circle_rounded
                            : Icons.stop_circle_rounded,
                        _tracking ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _infoCard(
                        'Passengers',
                        '$_passengers',
                        Icons.people_rounded,
                        Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: _tracking
                            ? null
                            : () => setState(() => _tracking = true),
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('Start Trip'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: !_tracking
                            ? null
                            : () => setState(() => _tracking = false),
                        icon: const Icon(Icons.stop_rounded),
                        label: const Text('End Trip'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, color: color)),
          Text(label,
              style:
                  const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}
