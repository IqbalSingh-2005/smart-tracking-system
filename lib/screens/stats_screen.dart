import 'dart:async';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  // Simulated live values
  int _activeBuses = 12;
  int _passengersToday = 1243;
  int _ticketsSold = 456;
  double _onTimeRate = 87.4;
  double _avgSpeed = 42.0;
  int _activeRoutes = 8;
  int _uptimeSeconds = 0;
  late Timer _timer;

  static const _busStatuses = [
    _BusStatus('Bus 101', 'City Center → University', 42.0, true, Colors.green),
    _BusStatus('Bus 202', 'Market → Airport', 38.5, true, Colors.green),
    _BusStatus('Bus 303', 'Station → Mall', 0.0, false, Colors.red),
    _BusStatus('Bus 404', 'Industrial Area → Port', 51.2, true, Colors.green),
    _BusStatus('Bus 505', 'University → Bus Stand', 29.8, true, Colors.orange),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _uptimeSeconds++;
        // Simulate slight fluctuations
        _avgSpeed = 40.0 + (_uptimeSeconds % 7) * 0.4;
        if (_uptimeSeconds % 15 == 0) _passengersToday++;
        if (_uptimeSeconds % 30 == 0) _ticketsSold++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _uptime {
    final h = _uptimeSeconds ~/ 3600;
    final m = (_uptimeSeconds % 3600) ~/ 60;
    final s = _uptimeSeconds % 60;
    return '${h.toString().padLeft(2, '0')}:'
        '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF131929) : scheme.surface;
    final accentColor = isDark ? const Color(0xFF00B4D8) : scheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bar_chart_rounded, color: accentColor, size: 20),
            const SizedBox(width: 8),
            const Text('Live Network Stats'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // System uptime banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accentColor.withOpacity(0.35)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green.withOpacity(0.6),
                            blurRadius: 6)
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('System Online',
                      style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
                  const Spacer(),
                  Text('Uptime: $_uptime',
                      style: TextStyle(
                          color: accentColor.withOpacity(0.8),
                          fontSize: 12,
                          fontFamily: 'monospace')),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // KPI grid
            Text('Key Metrics',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface.withOpacity(0.7),
                    letterSpacing: 0.5)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.9,
              children: [
                _kpiCard('Active\nBuses', '$_activeBuses',
                    Icons.directions_bus_rounded, Colors.cyan, cardColor),
                _kpiCard('Passengers\nToday', '$_passengersToday',
                    Icons.people_rounded, Colors.green, cardColor),
                _kpiCard('On-Time\nRate', '${_onTimeRate.toStringAsFixed(1)}%',
                    Icons.access_time_rounded, Colors.orange, cardColor),
                _kpiCard('Tickets\nSold', '$_ticketsSold',
                    Icons.confirmation_number_rounded, Colors.purple, cardColor),
                _kpiCard('Avg Speed', '${_avgSpeed.toStringAsFixed(1)}\nkm/h',
                    Icons.speed_rounded, Colors.blue, cardColor),
                _kpiCard('Active\nRoutes', '$_activeRoutes',
                    Icons.alt_route_rounded, Colors.teal, cardColor),
              ],
            ),
            const SizedBox(height: 24),

            // Live bus feed
            Text('Live Bus Feed',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface.withOpacity(0.7),
                    letterSpacing: 0.5)),
            const SizedBox(height: 12),
            ..._busStatuses.map((b) => _busRow(b, cardColor, accentColor)),
          ],
        ),
      ),
    );
  }

  Widget _kpiCard(String label, String value, IconData icon, Color color,
      Color cardColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(value,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 13, color: color)),
          const SizedBox(height: 3),
          Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
        ],
      ),
    );
  }

  Widget _busRow(_BusStatus b, Color cardColor, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: b.statusColor.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Icon(Icons.directions_bus_rounded, color: b.statusColor, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(b.busName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 2),
                Text(b.route,
                    style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.55))),
              ],
            ),
          ),
          if (b.isRunning)
            Text('${b.speed.toStringAsFixed(1)} km/h',
                style: TextStyle(
                    fontSize: 12,
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: b.statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: b.statusColor.withOpacity(0.4)),
            ),
            child: Text(
              b.isRunning ? 'Running' : 'Stopped',
              style: TextStyle(
                  color: b.statusColor,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _BusStatus {
  final String busName;
  final String route;
  final double speed;
  final bool isRunning;
  final Color statusColor;
  const _BusStatus(
      this.busName, this.route, this.speed, this.isRunning, this.statusColor);
}
