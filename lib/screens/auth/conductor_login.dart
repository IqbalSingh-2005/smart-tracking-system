import 'package:flutter/material.dart';

class ConductorLoginScreen extends StatelessWidget {
  const ConductorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conductor Login")),
      body: const Center(
        child: Text("Conductor Login Screen"),
      ),
    );
  }
}