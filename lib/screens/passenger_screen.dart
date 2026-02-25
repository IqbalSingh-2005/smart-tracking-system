import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PassengerScreen extends StatefulWidget {
  const PassengerScreen({super.key});

  @override
  State<PassengerScreen> createState() =>
      _PassengerScreenState();
}

class _PassengerScreenState
    extends State<PassengerScreen> {

  double lat=31.3260;
  double lng=75.5762;

  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Live Bus Tracking"),
      ),

      body: StreamBuilder(

        stream: FirebaseFirestore.instance
            .collection("buses")
            .doc("bus_101")
            .snapshots(),

        builder:(context,snapshot){

          if(!snapshot.hasData)
          {
            return const Center(
                child:
                CircularProgressIndicator());
          }

          var data=snapshot.data;

          lat=data!['latitude'];
          lng=data['longitude'];

          return GoogleMap(

            initialCameraPosition:

            CameraPosition(
              target:
              LatLng(lat,lng),
              zoom:15,
            ),

            markers:{

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

          );

        },

      ),

    );
  }
}