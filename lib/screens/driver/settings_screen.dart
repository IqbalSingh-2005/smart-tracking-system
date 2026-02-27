import 'package:flutter/material.dart';
import '../../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // ── Appearance ──────────────────────────────────────────────────
          _sectionHeader('Appearance', scheme),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (_, mode, __) {
              final dark = mode == ThemeMode.dark;
              return SwitchListTile(
                secondary: Icon(
                  dark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  color: scheme.primary,
                ),
                title: const Text('Dark Mode'),
                subtitle: Text(dark ? 'Dark technical interface' : 'Light interface'),
                value: dark,
                onChanged: (v) {
                  themeNotifier.value = v ? ThemeMode.dark : ThemeMode.light;
                },
              );
            },
          ),
          const Divider(height: 1),

          // ── Notifications ────────────────────────────────────────────────
          _sectionHeader('Notifications', scheme),
          SwitchListTile(
            secondary: Icon(Icons.notifications_rounded, color: scheme.primary),
            title: const Text('Push Notifications'),
            subtitle: const Text('Alerts, delays and trip updates'),
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
          ),
          const Divider(height: 1),

          // ── Language ─────────────────────────────────────────────────────
          _sectionHeader('Language & Region', scheme),
          ListTile(
            leading: Icon(Icons.language_rounded, color: scheme.primary),
            title: const Text('Language'),
            subtitle: Text(_language),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
            onTap: () => _pickLanguage(context),
          ),
          const Divider(height: 1),

          // ── About ─────────────────────────────────────────────────────────
          _sectionHeader('About', scheme),
          ListTile(
            leading: Icon(Icons.info_outline_rounded, color: scheme.primary),
            title: const Text('App Version'),
            subtitle: const Text('v1.0.0'),
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined, color: scheme.primary),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.open_in_new_rounded, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: scheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Future<void> _pickLanguage(BuildContext context) async {
    final langs = ['English', 'Hindi', 'Punjabi'];
    final picked = await showDialog<String>(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Select Language'),
        children: langs
            .map((l) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, l),
                  child: Text(l),
                ))
            .toList(),
      ),
    );
    if (picked != null) setState(() => _language = picked);
  }
}