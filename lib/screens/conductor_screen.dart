import 'package:flutter/material.dart';

class ConductorScreen extends StatelessWidget {
  const ConductorScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Conductor Panel"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height:20),

            Card(

              child: ListTile(

                leading: const Icon(Icons.qr_code,size:40),

                title: const Text("Scan Ticket"),

                subtitle: const Text("Scan passenger QR"),

                onTap: (){},

              ),
            ),

            const SizedBox(height:20),

            Card(

              child: ListTile(

                leading: const Icon(Icons.money,size:40),

                title: const Text("Collect Fare"),

                subtitle: const Text("Manual ticket"),

                onTap: (){},

              ),
            ),

            const SizedBox(height:20),

            Card(

              child: ListTile(

                leading: const Icon(Icons.people,size:40),

                title: const Text("Passengers"),

                subtitle: const Text("View passengers"),

                onTap: (){},

              ),
            ),

          ],
        ),
      ),
    );
  }
}