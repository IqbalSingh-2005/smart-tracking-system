import 'package:flutter/material.dart';
import 'dart:async';
import 'role_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {

    Future.delayed(const Duration(seconds: 3), () {

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RoleSelectionScreen(),
          ),
        );
      }

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.indigo,

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.directions_bus,
              size: 120,
              color: Colors.white,
            ),

            const SizedBox(height: 20),

            const Text(
              "Smart Transport System",
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            const CircularProgressIndicator(
              color: Colors.white,
            ),

          ],

        ),

      ),

    );

  }

}