import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onChanged;

  const SettingsPage({
    super.key,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Settings', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDark,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
