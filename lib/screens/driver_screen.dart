import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {

  GoogleMapController? mapController;

  StreamSubscription<Position>? positionStream;

  double lat = 31.3260;
  double lng = 75.5762;

  double speed = 0;

  bool isOnline = false;

  // START DUTY
  Future startDuty() async {

    LocationPermission permission =
        await Geolocator.requestPermission();

    setState(() {
      isOnline=true;
    });

    positionStream =
        Geolocator.getPositionStream(
            locationSettings:
            const LocationSettings(
                accuracy: LocationAccuracy.high,
                distanceFilter: 5))
            .listen((Position position) {

      lat = position.latitude;
      lng = position.longitude;

      speed = position.speed * 3.6;

      setState(() {});

      FirebaseFirestore.instance
          .collection("buses")
          .doc("bus_101")
          .set({

        "latitude":lat,
        "longitude":lng,
        "speed":speed,
        "status":"online"

      });

      mapController?.animateCamera(
        CameraUpdate.newLatLng(
            LatLng(lat,lng)),
      );

    });

  }

  // STOP DUTY

  Future stopDuty() async {

    positionStream?.cancel();

    FirebaseFirestore.instance
        .collection("buses")
        .doc("bus_101")
        .update({

      "status":"offline"

    });

    setState(() {
      isOnline=false;
    });

  }

  Widget infoCard(String title,String value,IconData icon)
  {
    return Container(

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),

        boxShadow: const [
          BoxShadow(
              blurRadius: 5,
              color: Colors.black12)
        ],

      ),

      child: Row(
        children: [

          Icon(icon,color: Colors.indigo),

          const SizedBox(width:10),

          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold),
          ),

          const Spacer(),

          Text(value)

        ],
      ),

    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Driver Dashboard"),
        actions: [

          IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.logout))

        ],
      ),

      body: Column(

        children: [

          // MAP

          Expanded(

            flex: 5,

            child: GoogleMap(

              initialCameraPosition:

              CameraPosition(
                target: LatLng(lat,lng),
                zoom: 15,
              ),

              markers: {

                Marker(
                  markerId:
                  const MarkerId("bus"),

                  position:
                  LatLng(lat,lng),

                )

              },

              onMapCreated:(controller){

                mapController=controller;

              },

            ),

          ),

          Expanded(

            flex: 4,

            child: Container(

              padding: const EdgeInsets.all(20),

              decoration: const BoxDecoration(

                  color: Colors.grey,

                  borderRadius:

                  BorderRadius.vertical(
                      top:
                      Radius.circular(20))

              ),

              child: Column(

                children: [

                  infoCard(
                      "Latitude",
                      lat.toStringAsFixed(4),
                      Icons.location_on),

                  const SizedBox(height:10),

                  infoCard(
                      "Longitude",
                      lng.toStringAsFixed(4),
                      Icons.map),

                  const SizedBox(height:10),

                  infoCard(
                      "Speed",
                      "${speed.toStringAsFixed(1)} km/h",
                      Icons.speed),

                  const SizedBox(height:20),

                  SizedBox(

                    width: double.infinity,

                    height: 50,

                    child: ElevatedButton(

                      style:

                      ElevatedButton.styleFrom(

                        backgroundColor:

                        isOnline
                            ? Colors.red
                            : Colors.green,

                      ),

                      onPressed:

                      isOnline
                          ? stopDuty
                          : startDuty,

                      child:

                      Text(

                        isOnline
                            ? "STOP DUTY"
                            : "START DUTY",

                        style:
                        const TextStyle(
                            fontSize:18),

                      ),

                    ),

                  )

                ],
              ),

            ),

          )

        ],
      ),

    );
  }
}