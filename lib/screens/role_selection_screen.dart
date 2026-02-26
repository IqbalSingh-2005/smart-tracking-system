import 'package:flutter/material.dart';

import 'auth/driver_login.dart';
import 'auth/conductor_login.dart';
import 'auth/passenger_login.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  Widget roleButton(
      BuildContext context,
      String title,
      IconData icon,
      Widget screen,
      Color color,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),

      child: SizedBox(
        width: double.infinity,

        child: ElevatedButton(

          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(18),
            backgroundColor: color,
          ),

          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => screen,
              ),
            );

          },

          child: Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Icon(
                icon,
                size: 28,
              ),

              const SizedBox(width: 10),

              Text(
                title,
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Select Role"),
        centerTitle: true,
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.directions_bus,
              size: 100,
              color: Colors.indigo,
            ),

            const SizedBox(height: 40),

            roleButton(
              context,
              "Passenger",
              Icons.person,
              const PassengerLoginScreen(),
              Colors.green,
            ),

            roleButton(
              context,
              "Driver",
              Icons.drive_eta,
              const DriverLoginScreen(),
              Colors.blue,
            ),

            roleButton(
              context,
              "Conductor",
              Icons.confirmation_number,
              const ConductorLoginScreen(),
              Colors.orange,
            ),

          ],
        ),
      ),
    );
  }
}