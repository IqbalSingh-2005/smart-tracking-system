import 'package:flutter/material.dart';

class BusStatusScreen extends StatelessWidget {
  const BusStatusScreen({super.key});

  static const _stats = [
    _Stat('Engine', 'Nominal', Icons.settings_rounded, Colors.green),
    _Stat('Fuel Level', '74%', Icons.local_gas_station_rounded, Colors.orange),
    _Stat('Tyre Pressure', 'OK', Icons.tire_repair_rounded, Colors.blue),
    _Stat('Speed Sensor', 'Active', Icons.speed_rounded, Colors.cyan),
    _Stat('GPS Module', 'Online', Icons.gps_fixed_rounded, Colors.green),
    _Stat('Door Sensor', 'Closed', Icons.sensor_door_rounded, Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Status'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Health banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade700, Colors.green.shade500],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.directions_bus_rounded,
                      color: Colors.white, size: 36),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bus PB08-101',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      Text('All Systems Operational',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.check_circle_rounded,
                      color: Colors.white, size: 28),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('System Diagnostics',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface.withOpacity(0.6),
                    letterSpacing: 0.8)),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.3,
              children: _stats
                  .map((s) => _statCard(s, scheme, isDark))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(_Stat s, ColorScheme scheme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131929) : scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: s.color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(s.icon, color: s.color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(s.label,
                    style: TextStyle(
                        fontSize: 11,
                        color: scheme.onSurface.withOpacity(0.6))),
                Text(s.value,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: s.color)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat {
  final String label, value;
  final IconData icon;
  final Color color;
  const _Stat(this.label, this.value, this.icon, this.color);
}