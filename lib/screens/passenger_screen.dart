import 'package:flutter/material.dart';

class PassengerScreen extends StatelessWidget {
  const PassengerScreen({super.key});

  static const _items = [
    _MenuItem('Track Bus', Icons.location_on_rounded, '/trackbus', Color(0xFF1E88E5)),
    _MenuItem('Routes', Icons.alt_route_rounded, '/routes', Color(0xFF43A047)),
    _MenuItem('Schedule', Icons.schedule_rounded, '/schedule', Color(0xFFFB8C00)),
    _MenuItem('Tickets', Icons.confirmation_number_rounded, '/tickets', Color(0xFF8E24AA)),
    _MenuItem('My Tickets', Icons.receipt_long_rounded, '/mytickets', Color(0xFF00ACC1)),
    _MenuItem('History', Icons.history_rounded, '/history', Color(0xFF6D4C41)),
    _MenuItem('Alerts', Icons.notifications_rounded, '/alerts', Color(0xFFE53935)),
    _MenuItem('Profile', Icons.person_rounded, '/profile', Color(0xFF3949AB)),
    _MenuItem('Help Bot', Icons.smart_toy_rounded, '/chatbot', Color(0xFF00897B)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Panel'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/chatbot'),
            icon: const Icon(Icons.smart_toy_rounded),
            tooltip: 'Help Bot',
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: _items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, i) {
            final item = _items[i];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, item.route),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: item.color.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item.icon, color: item.color, size: 28),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MenuItem {
  final String label;
  final IconData icon;
  final String route;
  final Color color;
  const _MenuItem(this.label, this.icon, this.route, this.color);
}
