import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 36),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [scheme.primary, scheme.primary.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person_rounded,
                        size: 52, color: Colors.white),
                  ),
                  SizedBox(height: 14),
                  Text('Passenger Name',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(height: 4),
                  Text('passenger@email.com',
                      style:
                          TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _tile(Icons.phone_rounded, 'Phone', '+91 98765 43210'),
            _tile(Icons.location_on_rounded, 'City', 'Jalandhar, Punjab'),
            _tile(Icons.confirmation_number_rounded, 'Tickets Booked', '12'),
            _tile(Icons.history_rounded, 'Total Trips', '18'),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.edit_rounded),
                  label: const Text('Edit Profile'),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.logout_rounded, color: Colors.red),
                  label: const Text('Logout',
                      style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red)),
                  onPressed: () => Navigator.popUntil(
                      context, (r) => r.isFirst),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  static Widget _tile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(label,
          style: const TextStyle(
              fontSize: 13, color: Colors.grey)),
      subtitle: Text(value,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600)),
    );
  }
}
