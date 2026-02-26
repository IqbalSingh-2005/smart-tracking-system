import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {

  StreamSubscription<Position>? stream;

  bool tracking = false;

  /// START LIVE TRACKING
  void startTracking() async {

    LocationPermission permission =
    await Geolocator.requestPermission();

    if(permission == LocationPermission.denied){
      return;
    }

    setState(() {
      tracking = true;
    });

    stream = Geolocator.getPositionStream(

      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),

    ).listen((Position position) {

      FirebaseFirestore.instance
          .collection("buses")
          .doc("bus101")
          .set({

        "lat": position.latitude,
        "lng": position.longitude,
        "time": DateTime.now()

      });

    });

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Live Tracking Started"))
    );
  }



  /// STOP TRACKING
  void stopTracking(){

    stream?.cancel();

    setState(() {
      tracking = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tracking Stopped"))
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Driver Live Tracking"),
      ),

      body: Column(

        children: [

          const SizedBox(height: 40),

          Icon(
            tracking
                ? Icons.gps_fixed
                : Icons.gps_off,
            size: 80,
            color: Colors.indigo,
          ),

          const SizedBox(height: 20),

          Text(
            tracking
                ? "Tracking ON"
                : "Tracking OFF",
            style: const TextStyle(fontSize: 22),
          ),

          const SizedBox(height: 40),

          ElevatedButton(

            onPressed: startTracking,

            child: const Text("Start Tracking"),

          ),

          const SizedBox(height: 20),

          ElevatedButton(

            onPressed: stopTracking,

            child: const Text("Stop Tracking"),

          )

        ],
      ),
    );
  }
}