import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  static const _schedules = [
    _Schedule('Bus 101', 'City Center → University', '08:00 AM', '05:00 PM', Colors.blue),
    _Schedule('Bus 202', 'Market → Airport', '09:00 AM', '06:00 PM', Colors.green),
    _Schedule('Bus 303', 'Station → Mall', '10:00 AM', '07:00 PM', Colors.orange),
    _Schedule('Bus 404', 'Industrial Area → Port', '07:00 AM', '04:00 PM', Colors.purple),
    _Schedule('Bus 505', 'University → Bus Stand', '06:00 AM', '09:00 PM', Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bus Schedule')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _schedules.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final s = _schedules[i];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: s.color.withOpacity(0.12),
                    child: Icon(Icons.directions_bus_rounded, color: s.color),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.busName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 3),
                        Text(s.route,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(children: [
                        const Icon(Icons.access_time_rounded,
                            size: 14, color: Colors.green),
                        const SizedBox(width: 4),
                        Text(s.departure,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.w600)),
                      ]),
                      const SizedBox(height: 4),
                      Row(children: [
                        const Icon(Icons.access_time_filled_rounded,
                            size: 14, color: Colors.red),
                        const SizedBox(width: 4),
                        Text(s.arrival,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.w600)),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Schedule {
  final String busName;
  final String route;
  final String departure;
  final String arrival;
  final Color color;
  const _Schedule(
      this.busName, this.route, this.departure, this.arrival, this.color);
}
