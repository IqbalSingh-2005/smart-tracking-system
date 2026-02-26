import 'package:flutter/material.dart';

class PassengerScreen extends StatelessWidget {
  const PassengerScreen({super.key});

  Widget option(
      BuildContext context,
      String title,
      IconData icon,
      String route){

    return GestureDetector(

      onTap: (){
        Navigator.pushNamed(context, route);
      },

      child: Card(

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(icon,size:30),

            const SizedBox(height:5),

            Text(title)

          ],

        ),

      ),

    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Passenger Panel"),

        actions: [

          IconButton(
              onPressed: (){
                Navigator.pushNamed(context,'/chatbot');
              },
              icon: const Icon(Icons.smart_toy)
          )

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

      body: GridView.count(

        crossAxisCount: 3,

        children: [

          option(context,"Track Bus",
              Icons.location_on,'/trackbus'),

          option(context,"Routes",
              Icons.alt_route,'/routes'),

          option(context,"Schedule",
              Icons.schedule,'/schedule'),

          option(context,"Tickets",
              Icons.confirmation_number,'/tickets'),

          option(context,"My Tickets",
              Icons.receipt,'/mytickets'),

          option(context,"History",
              Icons.history,'/history'),

          option(context,"Alerts",
              Icons.notifications,'/alerts'),

          option(context,"Profile",
              Icons.person,'/profile'),

          option(context,"Help Bot",
              Icons.smart_toy,'/chatbot'),

        ],

      ),

    );

  }

}