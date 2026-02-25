import 'package:flutter/material.dart';
import 'auth/driver_login.dart';
import 'auth/conductor_login.dart';
import 'auth/passenger_login.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  Widget buildRoleCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required Widget screen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.white),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Icon(Icons.directions_bus,
                    size: 80, color: Colors.white),

                const SizedBox(height: 20),

                const Text(
                  "Smart Transport System",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                buildRoleCard(
                  context: context,
                  title: "Passenger",
                  icon: Icons.person,
                  color: Colors.green,
                  screen: const PassengerLoginScreen(),
                ),

                buildRoleCard(
                  context: context,
                  title: "Driver",
                  icon: Icons.drive_eta,
                  color: Colors.orange,
                  screen: const DriverLoginScreen(),
                ),

                buildRoleCard(
                  context: context,
                  title: "Conductor",
                  icon: Icons.confirmation_number,
                  color: Colors.purple,
                  screen: const ConductorLoginScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}