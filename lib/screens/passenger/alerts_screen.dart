import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  static const _alerts = [
    _Alert(Icons.warning_amber_rounded, 'Bus 101 delayed by 15 min',
        'Heavy traffic on City Center route', Colors.orange, '10 min ago'),
    _Alert(Icons.info_rounded, 'New Route Added',
        'Route 505 now available: University → Bus Stand', Colors.blue,
        '2 hrs ago'),
    _Alert(Icons.check_circle_rounded, 'Ticket Confirmed',
        'Your ticket for Bus 202 has been confirmed', Colors.green, '5 hrs ago'),
    _Alert(Icons.cancel_rounded, 'Trip Cancelled',
        'Bus 303 trip on 26 Feb has been cancelled', Colors.red, 'Yesterday'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Service Alerts')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _alerts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final a = _alerts[i];
          return Card(
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: a.color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(a.icon, color: a.color),
              ),
              title: Text(a.title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(a.body, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(a.time,
                      style: TextStyle(
                          fontSize: 11, color: Colors.grey.shade500)),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

class _Alert {
  final IconData icon;
  final String title, body, time;
  final Color color;
  const _Alert(this.icon, this.title, this.body, this.color, this.time);
}
