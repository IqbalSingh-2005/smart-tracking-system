import 'package:flutter/material.dart';
import '../passenger_screen.dart';

class PassengerLoginScreen extends StatefulWidget {
  const PassengerLoginScreen({super.key});

  @override
  State<PassengerLoginScreen> createState() => _PassengerLoginScreenState();
}

class _PassengerLoginScreenState extends State<PassengerLoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  void _login() {
    setState(() => _loading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _loading = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PassengerScreen()),
      );
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: scheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_rounded,
                      size: 64, color: scheme.primary),
                ),
              ),
              const SizedBox(height: 28),
              const Text('Welcome Back',
                  style: TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Sign in to your passenger account',
                  style: TextStyle(
                      color: Colors.grey.shade600, fontSize: 14)),
              const SizedBox(height: 32),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _password,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _loading ? null : _login,
                  child: _loading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5))
                      : const Text('Continue as Passenger',
                          style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
