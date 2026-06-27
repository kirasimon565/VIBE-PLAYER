import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _buildSettingsTile('Audio Alchemy', 'Advanced equalizer', Icons.graphic_eq),
          _buildSettingsTile('Visual Vibe', 'Customize visualizer', Icons.auto_awesome),
          _buildSettingsTile('Gesture Studio', 'Custom mapping', Icons.touch_app),
          _buildSettingsTile('Smart Features', 'AI preference tuning', Icons.psychology),
          _buildSettingsTile('Privacy Vault', 'Incognito mode', Icons.security),
          SwitchListTile(
            title: const Text('VibeSync Technology'),
            subtitle: const Text('Sync with heart rate & breathing'),
            value: true,
            onChanged: (val) {},
            activeColor: Colors.purpleAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.purpleAccent),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
