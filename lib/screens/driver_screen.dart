import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({super.key});

  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {

  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoading = false;

  Future<void> loginDriver() async {
    setState(() => isLoading = true);

    try {
      final cred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(cred.user!.uid)
          .set({
        'role': 'driver',
      }, SetOptions(merge: true));

      Navigator.pushReplacementNamed(context, '/driver');

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text("Driver login failed"),
      ));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Driver Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: "Driver Email",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : loginDriver,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Login as Driver"),
            ),
          ],
        ),
      ),
    );
  }
}