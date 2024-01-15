import 'package:admin/constants.dart';
import 'package:admin/screens/main/components/header.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            SettingsList(),
          ],
        ),
      ),
    );
  }
}

class SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsTile(
          title: 'Account Settings',
          icon: Icons.person,
          onTap: () {
            // Handle tap
          },
        ),
        SettingsTile(
          title: 'Notifications',
          icon: Icons.notifications,
          onTap: () {
            // Handle tap
          },
        ),
        SettingsTile(
          title: 'Theme',
          icon: Icons.color_lens,
          onTap: () {
            // Handle tap
          },
        ),
        // Add more settings options as needed
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  SettingsTile({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}

// Don't forget to define `defaultPadding` and other constants used in the layout.
