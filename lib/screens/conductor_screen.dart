import 'package:flutter/material.dart';

class ConductorScreen extends StatelessWidget {
  const ConductorScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Conductor Panel"),

        actions: [

          IconButton(
              onPressed: (){
                Navigator.pushNamed(context,'/help');
              },
              icon: const Icon(Icons.help)
          ),

        ],
      ),

      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.red,

        onPressed: (){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("SOS Sent"))
          );
        },

        child: const Icon(Icons.warning),

      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            ElevatedButton(
              onPressed: (){},
              child: const Text("Scan Ticket"),
            ),

            const SizedBox(height:20),

            ElevatedButton(
              onPressed: (){},
              child: const Text("Verify Ticket"),
            ),

            const SizedBox(height:20),

            ElevatedButton(
              onPressed: (){},
              child: const Text("Passenger Count"),
            ),

            const SizedBox(height:20),

            ElevatedButton(
              onPressed: (){},
              child: const Text("Trip Start"),
            ),

            const SizedBox(height:20),

            ElevatedButton(
              onPressed: (){},
              child: const Text("Trip End"),
            ),

          ],

        ),

      ),

    );

  }

}