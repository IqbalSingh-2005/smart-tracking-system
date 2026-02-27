import 'package:flutter/material.dart';
import 'auth/driver_login.dart';
import 'auth/conductor_login.dart';
import 'auth/passenger_login.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  Widget _roleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget screen,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 16, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.directions_bus_rounded,
                  size: 72, color: Colors.white),
              const SizedBox(height: 12),
              const Text('Smart Transport System',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 6),
              const Text('Select your role to continue',
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Who are you?',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Choose your role to access the app',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13)),
                      const SizedBox(height: 16),
                      _roleCard(
                        context,
                        title: 'Passenger',
                        subtitle: 'Track buses, book tickets & more',
                        icon: Icons.person_rounded,
                        color: Colors.green,
                        screen: const PassengerLoginScreen(),
                      ),
                      _roleCard(
                        context,
                        title: 'Driver',
                        subtitle: 'Manage trips and share live location',
                        icon: Icons.drive_eta_rounded,
                        color: Colors.blue,
                        screen: const DriverLoginScreen(),
                      ),
                      _roleCard(
                        context,
                        title: 'Conductor',
                        subtitle: 'Verify tickets and manage passengers',
                        icon: Icons.confirmation_number_rounded,
                        color: Colors.orange,
                        screen: const ConductorLoginScreen(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
