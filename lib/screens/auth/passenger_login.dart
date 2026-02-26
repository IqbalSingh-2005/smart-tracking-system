import 'package:flutter/material.dart';

import '../passenger_screen.dart';

class PassengerLoginScreen
    extends StatelessWidget {

  const PassengerLoginScreen(
      {super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar:
      AppBar(
          title:
          const Text(
              "Passenger Login")),

      body: Center(

        child: ElevatedButton(

          onPressed: () {

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                    const PassengerScreen()));

          },

          child: const Text(
              "Continue as Passenger"),

        ),
      ),
    );
  }
}