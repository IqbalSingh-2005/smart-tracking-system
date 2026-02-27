import 'package:flutter/material.dart';

/// Smart Journey Planner – helps passengers find the best route between
/// two stops by surfacing Fastest, Cheapest, and Least-Crowded options.
class JourneyPlannerScreen extends StatefulWidget {
  const JourneyPlannerScreen({super.key});

  @override
  State<JourneyPlannerScreen> createState() => _JourneyPlannerScreenState();
}

class _JourneyPlannerScreenState extends State<JourneyPlannerScreen>
    with SingleTickerProviderStateMixin {
  final _fromCtrl = TextEditingController();
  final _toCtrl = TextEditingController();
  bool _loading = false;
  List<_JourneyOption>? _results;

  late final AnimationController _swapAnim;
  late final Animation<double> _swapTurns;

  // Popular stops shown as quick-pick chips
  static const _stops = [
    'Bus Stand',
    'City Center',
    'University Gate',
    'Airport Road',
    'Market Square',
    'Railway Station',
    'Hospital Block',
    'Tech Park',
    'Mall Road',
    'Industrial Area',
  ];

  // Pre-built route options (simulated)
  static const _options = [
    _JourneyOption(
      label: 'Fastest',
      icon: Icons.flash_on_rounded,
      color: Color(0xFF00B4D8),
      buses: 'Bus 101 → Bus 202',
      stops: 6,
      duration: '28 min',
      fare: '₹18',
      crowd: 0.70,
      transfers: 1,
      tag: 'Arrives 10:32 AM',
    ),
    _JourneyOption(
      label: 'Cheapest',
      icon: Icons.savings_rounded,
      color: Color(0xFF43A047),
      buses: 'Bus 303 (Direct)',
      stops: 9,
      duration: '41 min',
      fare: '₹12',
      crowd: 0.40,
      transfers: 0,
      tag: 'No transfer · Save ₹6',
    ),
    _JourneyOption(
      label: 'Least Crowded',
      icon: Icons.people_outline_rounded,
      color: Color(0xFF8E24AA),
      buses: 'Bus 404',
      stops: 7,
      duration: '35 min',
      fare: '₹15',
      crowd: 0.20,
      transfers: 0,
      tag: 'Comfortable ride',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _swapAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _swapTurns =
        Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _swapAnim, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fromCtrl.dispose();
    _toCtrl.dispose();
    _swapAnim.dispose();
    super.dispose();
  }

  // ── helpers ─────────────────────────────────────────────────────────────

  void _swap() {
    _swapAnim.forward(from: 0);
    final tmp = _fromCtrl.text;
    _fromCtrl.text = _toCtrl.text;
    _toCtrl.text = tmp;
    setState(() {});
  }

  Future<void> _search() async {
    if (_fromCtrl.text.trim().isEmpty || _toCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both From and To stops')),
      );
      return;
    }
    setState(() {
      _loading = true;
      _results = null;
    });
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1100));
    if (!mounted) return;
    setState(() {
      _loading = false;
      _results = _options;
    });
  }

  void _pickStop(String stop, bool isFrom) {
    setState(() {
      if (isFrom) {
        _fromCtrl.text = stop;
      } else {
        _toCtrl.text = stop;
      }
    });
  }

  // ── build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journey Planner'),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          _buildSearchCard(scheme, isDark),
          if (_loading) const LinearProgressIndicator(minHeight: 3),
          if (_results != null)
            Expanded(child: _buildResults(scheme, isDark))
          else if (!_loading)
            Expanded(child: _buildSuggestions(scheme)),
        ],
      ),
    );
  }

  // ── Search card ──────────────────────────────────────────────────────────

  Widget _buildSearchCard(ColorScheme scheme, bool isDark) {
    final gradStart =
        isDark ? const Color(0xFF0D1B2A) : const Color(0xFFE3F2FD);
    final gradEnd =
        isDark ? const Color(0xFF131929) : const Color(0xFFF8FBFF);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradStart, gradEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // From field
          _StopField(
            controller: _fromCtrl,
            hint: 'From stop…',
            icon: Icons.radio_button_checked_rounded,
            iconColor: const Color(0xFF43A047),
          ),
          // Divider with swap button
          Row(
            children: [
              const SizedBox(width: 14),
              Container(
                width: 1,
                height: 20,
                color: scheme.onSurface.withOpacity(0.12),
              ),
              const Spacer(),
              RotationTransition(
                turns: _swapTurns,
                child: IconButton(
                  icon: const Icon(Icons.swap_vert_rounded),
                  onPressed: _swap,
                  tooltip: 'Swap stops',
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
          // To field
          _StopField(
            controller: _toCtrl,
            hint: 'To stop…',
            icon: Icons.location_on_rounded,
            iconColor: const Color(0xFFE53935),
          ),
          const SizedBox(height: 14),
          // Search button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: scheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.search_rounded),
              label: const Text('Find Routes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              onPressed: _search,
            ),
          ),
        ],
      ),
    );
  }

  // ── Popular stop suggestions (before search) ─────────────────────────────

  Widget _buildSuggestions(ColorScheme scheme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.place_rounded,
                  size: 16, color: scheme.onSurface.withOpacity(0.6)),
              const SizedBox(width: 6),
              Text('Popular Stops',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface.withOpacity(0.6))),
            ],
          ),
          const SizedBox(height: 12),
          Text('Set as From',
              style: TextStyle(
                  fontSize: 12, color: scheme.onSurface.withOpacity(0.5))),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _stops
                .map((s) => ActionChip(
                      avatar: const Icon(Icons.radio_button_checked_rounded,
                          size: 14, color: Color(0xFF43A047)),
                      label: Text(s, style: const TextStyle(fontSize: 12)),
                      onPressed: () => _pickStop(s, true),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          Text('Set as To',
              style: TextStyle(
                  fontSize: 12, color: scheme.onSurface.withOpacity(0.5))),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _stops
                .map((s) => ActionChip(
                      avatar: const Icon(Icons.location_on_rounded,
                          size: 14, color: Color(0xFFE53935)),
                      label: Text(s, style: const TextStyle(fontSize: 12)),
                      onPressed: () => _pickStop(s, false),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  // ── Route results ────────────────────────────────────────────────────────

  Widget _buildResults(ColorScheme scheme, bool isDark) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      children: [
        // Journey summary banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: scheme.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.primary.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.route_rounded, color: scheme.primary, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${_fromCtrl.text}  →  ${_toCtrl.text}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: scheme.primary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: () => setState(() => _results = null),
                style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero),
                child: const Text('Change', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text('${_results!.length} Routes Found',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: scheme.onSurface.withOpacity(0.6))),
        const SizedBox(height: 10),
        ..._results!
            .map((opt) => _RouteCard(option: opt, isDark: isDark))
            .toList(),
      ],
    );
  }
}

// ── Reusable stop input field ─────────────────────────────────────────────

class _StopField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final Color iconColor;

  const _StopField({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  TextStyle(color: scheme.onSurface.withOpacity(0.4), fontSize: 14),
              filled: true,
              fillColor: scheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: scheme.outline.withOpacity(0.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: scheme.outline.withOpacity(0.25)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: scheme.primary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              isDense: true,
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }
}

// ── Route option card ─────────────────────────────────────────────────────

class _RouteCard extends StatelessWidget {
  final _JourneyOption option;
  final bool isDark;

  const _RouteCard({required this.option, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF131929) : Colors.white;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: option.color.withOpacity(0.35)),
        boxShadow: [
          BoxShadow(
            color: option.color.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: option.color.withOpacity(0.10),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              children: [
                Icon(option.icon, color: option.color, size: 18),
                const SizedBox(width: 7),
                Text(option.label,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: option.color)),
                const Spacer(),
                _CrowdMeter(crowd: option.crowd, color: option.color),
              ],
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bus & stops row
                Row(
                  children: [
                    const Icon(Icons.directions_bus_rounded,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(option.buses,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                    Text('${option.stops} stops',
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 10),
                // Stats row
                Row(
                  children: [
                    _StatChip(
                        icon: Icons.access_time_rounded,
                        label: option.duration,
                        color: option.color),
                    const SizedBox(width: 10),
                    _StatChip(
                        icon: Icons.currency_rupee_rounded,
                        label: option.fare,
                        color: option.color),
                    if (option.transfers == 0) ...[
                      const SizedBox(width: 10),
                      _StatChip(
                          icon: Icons.check_circle_outline_rounded,
                          label: 'Direct',
                          color: Colors.green),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Text(option.tag,
                    style: TextStyle(
                        fontSize: 11,
                        color: option.color.withOpacity(0.8),
                        fontStyle: FontStyle.italic)),
                const SizedBox(height: 12),
                // Action button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: option.color,
                      side: BorderSide(color: option.color.withOpacity(0.6)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    icon: const Icon(Icons.navigation_rounded, size: 16),
                    label: const Text('Plan This Route',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${option.label} route selected ✓'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Crowd-level meter (wifi-style bars) ───────────────────────────────────

class _CrowdMeter extends StatelessWidget {
  final double crowd; // 0.0 – 1.0
  final Color color;

  const _CrowdMeter({required this.crowd, required this.color});

  @override
  Widget build(BuildContext context) {
    final label = crowd < 0.35
        ? 'Low'
        : crowd < 0.65
            ? 'Medium'
            : 'High';
    final barColor = crowd < 0.35
        ? Colors.green
        : crowd < 0.65
            ? Colors.orange
            : Colors.red;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Three bars
        for (int i = 1; i <= 3; i++)
          Container(
            margin: const EdgeInsets.only(left: 3),
            width: 6,
            height: 6.0 + i * 4,
            decoration: BoxDecoration(
              color: (i / 3.0) <= crowd
                  ? barColor
                  : barColor.withOpacity(0.20),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(
                fontSize: 11,
                color: barColor,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// ── Small stat chip ───────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatChip(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────

class _JourneyOption {
  final String label;
  final IconData icon;
  final Color color;
  final String buses;
  final int stops;
  final String duration;
  final String fare;
  final double crowd;
  final int transfers;
  final String tag;

  const _JourneyOption({
    required this.label,
    required this.icon,
    required this.color,
    required this.buses,
    required this.stops,
    required this.duration,
    required this.fare,
    required this.crowd,
    required this.transfers,
    required this.tag,
  });
}
