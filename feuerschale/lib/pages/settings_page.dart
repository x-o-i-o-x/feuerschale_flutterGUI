import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

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
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Settings',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDark,
            onChanged: onChanged,
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: const Text("Shutdown"),
            trailing: ElevatedButton(
              onPressed: () {
                shutdown(context);
              },
              child: Icon(CupertinoIcons.power),
            ),
          ),
        ],
      ),
    );
  }
}

void shutdown(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Shutdown'),
        content: const Text('Shutdown Fireplace?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Process.run('/opt/rpi_shutdown.sh', []);
            },
            child: const Text('Shutdown'),
          ),
        ],
      );
    },
  );
}
