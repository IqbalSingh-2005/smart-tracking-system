import 'package:flutter/material.dart';
import 'driver/settings_screen.dart';

class ConductorScreen extends StatefulWidget {
  const ConductorScreen({super.key});

  @override
  State<ConductorScreen> createState() => _ConductorScreenState();
}

class _ConductorScreenState extends State<ConductorScreen> {
  int _count = 0;
  bool _tripActive = false;
  int _scanned = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conductor Panel'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/stats'),
            icon: const Icon(Icons.bar_chart_rounded),
            tooltip: 'Live Stats',
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/help'),
            icon: const Icon(Icons.help_outline_rounded),
            tooltip: 'Help',
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
            icon: const Icon(Icons.settings_rounded),
            tooltip: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('🚨 SOS Sent!'))),
        icon: const Icon(Icons.warning_amber_rounded),
        label: const Text('SOS'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Trip Status Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _tripActive
                      ? [Colors.green.shade400, Colors.green.shade700]
                      : [Colors.grey.shade400, Colors.grey.shade600],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.directions_bus_rounded,
                      color: Colors.white, size: 36),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Bus PB08-101',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      Text(
                          _tripActive ? 'Trip In Progress' : 'No Active Trip',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// Passenger Counter
            const Text('Passenger Counter',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _counterBtn(Icons.remove_rounded, Colors.red, () {
                      if (_count > 0) setState(() => _count--);
                    }),
                    Column(
                      children: [
                        Text('$_count',
                            style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: scheme.primary)),
                        const Text('Passengers',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    _counterBtn(Icons.add_rounded, Colors.green, () {
                      setState(() => _count++);
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Quick Actions
            const Text('Quick Actions',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.2,
              children: [
                _actionBtn(
                  'Scan Ticket',
                  Icons.qr_code_scanner_rounded,
                  Colors.indigo,
                  () {
                    setState(() => _scanned++);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Ticket $_scanned scanned ✓')));
                  },
                ),
                _actionBtn(
                  'Verify Ticket',
                  Icons.verified_rounded,
                  Colors.teal,
                  () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ticket Verified ✓'))),
                ),
                _actionBtn(
                  'Start Trip',
                  Icons.play_arrow_rounded,
                  Colors.green,
                  () => setState(() => _tripActive = true),
                ),
                _actionBtn(
                  'End Trip',
                  Icons.stop_rounded,
                  Colors.red,
                  () => setState(() => _tripActive = false),
                ),
              ],
            ),

            if (_scanned > 0) ...[
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.qr_code_rounded,
                      color: Colors.indigo),
                  title: Text('$_scanned ticket(s) scanned this trip'),
                  subtitle: const Text('All valid'),
                  trailing:
                      const Icon(Icons.check_circle_rounded, color: Colors.green),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _counterBtn(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }

  Widget _actionBtn(
      String label, IconData icon, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: color.withOpacity(0.3))),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}
