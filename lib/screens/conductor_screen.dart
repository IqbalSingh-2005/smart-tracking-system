import 'package:flutter/material.dart';

class ConductorScreen extends StatelessWidget {
  const ConductorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conductor Panel")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Conductor",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.qr_code),
                title: const Text("Scan Passenger Ticket"),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.people),
                title: const Text("View Passenger Count"),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.verified_user),
                title: const Text("Verify Identity"),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}