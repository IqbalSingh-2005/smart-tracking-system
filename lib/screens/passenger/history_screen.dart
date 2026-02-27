import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const _trips = [
    _Trip('Bus 101', 'City Center', 'University', '25 Feb 2026', '₹25'),
    _Trip('Bus 202', 'Market', 'Airport', '22 Feb 2026', '₹40'),
    _Trip('Bus 303', 'Station', 'Mall', '20 Feb 2026', '₹20'),
    _Trip('Bus 101', 'University', 'City Center', '18 Feb 2026', '₹25'),
    _Trip('Bus 505', 'Bus Stand', 'University', '15 Feb 2026', '₹15'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Travel History')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _trips.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final t = _trips[i];
          return Card(
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.directions_bus_rounded,
                    color: Colors.indigo),
              ),
              title: Text('${t.from} → ${t.to}',
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('${t.bus}  ·  ${t.date}',
                  style: const TextStyle(fontSize: 12)),
              trailing: Text(t.fare,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.indigo)),
            ),
          );
        },
      ),
    );
  }
}

class _Trip {
  final String bus, from, to, date, fare;
  const _Trip(this.bus, this.from, this.to, this.date, this.fare);
}
