import 'package:flutter/material.dart';

class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({super.key});

  static final _tickets = [
    _Ticket('PB08-101', 'City Center', 'University', '27 Feb 2026', '12', '₹25', true),
    _Ticket('PB08-202', 'Market', 'Airport', '28 Feb 2026', '7', '₹40', false),
    _Ticket('PB08-303', 'Station', 'Mall', '01 Mar 2026', '3', '₹20', true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tickets')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _tickets.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final t = _tickets[i];
          return Card(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: t.active
                        ? Colors.indigo.withOpacity(0.06)
                        : Colors.grey.withOpacity(0.06),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.directions_bus_rounded,
                          color: Colors.indigo, size: 28),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t.busNo,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                            Text('${t.from} → ${t.to}',
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: t.active
                              ? Colors.green.withOpacity(0.12)
                              : Colors.grey.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          t.active ? 'Active' : 'Used',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: t.active ? Colors.green : Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _info(Icons.calendar_today_rounded, t.date),
                      _info(Icons.airline_seat_recline_normal_rounded,
                          'Seat ${t.seat}'),
                      _info(Icons.currency_rupee_rounded, t.fare),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _info(IconData icon, String text) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      );
}

class _Ticket {
  final String busNo, from, to, date, seat, fare;
  final bool active;
  const _Ticket(
      this.busNo, this.from, this.to, this.date, this.seat, this.fare,
      this.active);
}
