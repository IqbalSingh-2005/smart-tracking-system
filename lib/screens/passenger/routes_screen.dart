import 'package:flutter/material.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  static const _routes = [
    _Route('Route 101', 'City Center → Bus Stand → University',
        ['City Center', 'Clock Tower', 'Bus Stand', 'University'], Colors.blue),
    _Route('Route 202', 'Market → Hospital → Airport',
        ['Market', 'Main Chowk', 'Hospital', 'Airport'], Colors.green),
    _Route('Route 303', 'Railway Station → Mall → Park',
        ['Railway Station', 'Old Town', 'Shopping Mall', 'City Park'], Colors.orange),
    _Route('Route 404', 'Industrial Area → Port',
        ['Industrial Area', 'Highway Exit', 'Dock Road', 'Port'], Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bus Routes')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _routes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final r = _routes[i];
          return Card(
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: r.color.withOpacity(0.15),
                child: Icon(Icons.directions_bus_rounded, color: r.color),
              ),
              title: Text(r.name,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(r.description,
                  style: const TextStyle(fontSize: 12)),
              children: [
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Stops',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(height: 8),
                      ...r.stops.asMap().entries.map((e) => Row(
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 8,
                                    backgroundColor: r.color,
                                    child: Text('${e.key + 1}',
                                        style: const TextStyle(
                                            fontSize: 9,
                                            color: Colors.white)),
                                  ),
                                  if (e.key < r.stops.length - 1)
                                    Container(
                                      width: 2,
                                      height: 24,
                                      color: r.color.withOpacity(0.4),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Text(e.value,
                                  style: const TextStyle(fontSize: 13)),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Route {
  final String name;
  final String description;
  final List<String> stops;
  final Color color;
  const _Route(this.name, this.description, this.stops, this.color);
}
