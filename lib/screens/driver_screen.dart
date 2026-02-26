import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {

  LatLng location = LatLng(31.3260,75.5762);

  bool tracking=false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Driver Panel"),

        actions: [

          IconButton(
              onPressed: (){
                Navigator.pushNamed(context,'/help');
              },
              icon: const Icon(Icons.help)
          ),

          IconButton(
              onPressed: (){
                Navigator.pushNamed(context,'/chatbot');
              },
              icon: const Icon(Icons.smart_toy)
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

      body: Column(

        children: [

          Expanded(

            child: FlutterMap(

              options: MapOptions(
                initialCenter: location,
                initialZoom: 15,
              ),

              children: [

                TileLayer(
                  urlTemplate:
                  "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),

                MarkerLayer(

                  markers: [

                    Marker(
                      point: location,
                      width: 80,
                      height: 80,

                      child: const Icon(
                        Icons.directions_bus,
                        size: 40,
                        color: Colors.red,
                      ),

                    )

                  ],

                )

              ],

            ),

          ),

          Container(

            padding: const EdgeInsets.all(20),

            child: Column(

              children: [

                const Text("Bus Number: PB08-101"),

                const SizedBox(height:10),

                Text(
                  tracking
                      ? "Status: Running"
                      : "Status: Stopped",
                ),

                const SizedBox(height:10),

                ElevatedButton(

                  onPressed: (){
                    setState(() {
                      tracking=true;
                    });
                  },

                  child: const Text("Start Trip"),

                ),

                const SizedBox(height:10),

                ElevatedButton(

                  onPressed: (){
                    setState(() {
                      tracking=false;
                    });
                  },

                  child: const Text("Stop Trip"),

                ),

              ],

            ),

          )

        ],

      ),

    );

  }

}