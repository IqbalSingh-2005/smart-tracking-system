import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final _ctrl = TextEditingController();
  String _reply = '';
  bool _showAgent = false;

  static const _faq = [
    _FAQ('How do I track my bus?',
        'Go to Track Bus on the passenger panel to see the live bus location on the map.'),
    _FAQ('How do I book a ticket?',
        'Open the Tickets section, fill in your From/To locations and travel date, then tap Book Ticket.'),
    _FAQ('What if the bus is late?',
        'Check the Alerts screen for delay notifications, or use Track Bus for the latest location.'),
    _FAQ('How do I contact support?',
        'Tap the Call Agent button below or email us at support@smarttransport.in'),
  ];

  void _solveProblem() {
    final t = _ctrl.text.toLowerCase();
    _showAgent = false;
    if (t.contains('map') || t.contains('gps')) {
      _reply = '✅ Check that GPS and Internet are enabled on your device.';
    } else if (t.contains('login') || t.contains('password')) {
      _reply = '✅ Try restarting the app. If the problem persists, reset your password.';
    } else if (t.contains('tracking') || t.contains('bus not showing')) {
      _reply = '✅ The driver must have started the trip for live tracking to work.';
    } else if (t.contains('ticket')) {
      _reply = '✅ Make sure your From/To fields are filled before booking.';
    } else {
      _reply = '❌ AI could not resolve this issue automatically.\nPlease contact a support agent.';
      _showAgent = true;
    }
    setState(() {});
  }

  Future<void> _callAgent() async {
    final uri = Uri.parse('tel:9876543210');
    await launchUrl(uri);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Help Center')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// AI Search
            const Text('Describe your problem',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _ctrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'e.g. Bus not showing on map…',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: _solveProblem,
                icon: const Icon(Icons.auto_fix_high_rounded),
                label: const Text('Solve with AI'),
              ),
            ),
            if (_reply.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _showAgent
                      ? Colors.red.withOpacity(0.07)
                      : Colors.green.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: _showAgent
                          ? Colors.red.withOpacity(0.3)
                          : Colors.green.withOpacity(0.3)),
                ),
                child: Text(_reply,
                    style: TextStyle(
                        fontSize: 14,
                        color: _showAgent ? Colors.red.shade700 : Colors.green.shade700)),
              ),
            ],
            if (_showAgent) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white),
                  onPressed: _callAgent,
                  icon: const Icon(Icons.phone_rounded),
                  label: const Text('Call Support Agent'),
                ),
              ),
            ],

            const SizedBox(height: 28),

            /// FAQ
            const Text('Frequently Asked Questions',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ..._faq.map(
              (f) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ExpansionTile(
                  title: Text(f.question,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                      child: Text(f.answer,
                          style: const TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FAQ {
  final String question, answer;
  const _FAQ(this.question, this.answer);
}
