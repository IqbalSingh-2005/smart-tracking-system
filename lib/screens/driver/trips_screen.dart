import 'package:flutter/material.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  static const _trips = [
    _Trip('Trip 1', 'City Center → Bus Stand', '08:05 AM', '09:10 AM', 42, true),
    _Trip('Trip 2', 'University → Market', '10:30 AM', '11:45 AM', 38, true),
    _Trip('Trip 3', 'Market → Airport', '01:15 PM', '02:50 PM', 51, false),
    _Trip('Trip 4', 'Station → Mall', '03:20 PM', '04:10 PM', 33, true),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Trip History')),
      body: Column(
        children: [
          // Summary bar
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border:
                  Border.all(color: scheme.primary.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _summaryItem('Total Trips', '${_trips.length}',
                    Icons.route_rounded, scheme.primary),
                _summaryItem('On Time', '3', Icons.check_circle_rounded,
                    Colors.green),
                _summaryItem(
                    'Delayed', '1', Icons.cancel_rounded, Colors.orange),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _trips.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final t = _trips[i];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: scheme.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.directions_bus_rounded,
                              color: scheme.primary, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(t.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              const SizedBox(height: 3),
                              Text(t.route,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: scheme.onSurface
                                          .withOpacity(0.55))),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.access_time_rounded,
                                      size: 12, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text('${t.start} → ${t.end}',
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${t.avgSpeed} km/h',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: scheme.primary)),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: t.onTime
                                    ? Colors.green.withOpacity(0.12)
                                    : Colors.orange.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                t.onTime ? 'On Time' : 'Delayed',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: t.onTime
                                        ? Colors.green
                                        : Colors.orange,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: color)),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}

class _Trip {
  final String name, route, start, end;
  final int avgSpeed;
  final bool onTime;
  const _Trip(this.name, this.route, this.start, this.end, this.avgSpeed,
      this.onTime);
}