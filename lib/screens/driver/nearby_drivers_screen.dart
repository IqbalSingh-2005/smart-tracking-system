import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyDriversScreen extends StatelessWidget {
  const NearbyDriversScreen({super.key});

  static const _drivers = [
    _NearbyDriver('Rajveer Singh', 'PB08-202', '0.4 km', '9812345678'),
    _NearbyDriver('Harpreet Kaur', 'PB08-315', '1.1 km', '9823456789'),
    _NearbyDriver('Gurjeet Pal', 'PB08-118', '1.8 km', '9834567890'),
    _NearbyDriver('Mandeep Kumar', 'PB08-427', '2.3 km', '9845678901'),
    _NearbyDriver('Sukhwinder Gill', 'PB08-509', '3.0 km', '9856789012'),
  ];

  Future<void> _call(BuildContext context, String phone) async {
    final uri = Uri.parse('tel:$phone');
    final canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      await launchUrl(uri);
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to make a call on this device.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Drivers'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded, color: Colors.orange),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Drivers within 5 km of your current location. Tap Call for emergency assistance.',
                    style: TextStyle(
                        fontSize: 13, color: Colors.orange.shade800),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${_drivers.length} drivers nearby',
              style: TextStyle(
                  fontSize: 13,
                  color: scheme.onSurface.withOpacity(0.6)),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              itemCount: _drivers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final d = _drivers[i];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: scheme.primary.withOpacity(0.12),
                      child: Icon(Icons.person_rounded,
                          color: scheme.primary),
                    ),
                    title: Text(d.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Text('Bus: ${d.busNo}',
                            style: const TextStyle(fontSize: 12)),
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded,
                                size: 12, color: Colors.grey),
                            const SizedBox(width: 2),
                            Text(d.distance,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                    trailing: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () => _call(context, d.phone),
                      icon: const Icon(Icons.phone_rounded, size: 16),
                      label: const Text('Call',
                          style: TextStyle(fontSize: 13)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NearbyDriver {
  final String name, busNo, distance, phone;
  const _NearbyDriver(this.name, this.busNo, this.distance, this.phone);
}
