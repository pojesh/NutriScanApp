import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isNotificationsEnabled = true; // Initial notification state
  bool isHistorySyncEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Theme(
        data: ThemeData(
          // ... other theme properties (optional)
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, // Text color for both states
              backgroundColor: Colors.black, // Background color for both states
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Add rounded corners
              ),
            ),

          ),
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(Colors.white), // White thumb
            trackColor: MaterialStateProperty.all(Colors.black),  // Grey track
          ),
          // ... other theme properties
        ),
        child: ListView(
          children: [
            // Notification settings
            ListTile(
              title: Text('Notifications'),
              trailing: Switch(
                value: isNotificationsEnabled, // Use state variable
                onChanged: (value) {
                  setState(() {
                    isNotificationsEnabled = value;
                  });
                },
              ),
            ),
            Divider(),
            // More settings options...
            // Theme settings (light/dark mode) (placeholder, functionality not added)
            ListTile(
              title: Text('Theme'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Light'),
                  Radio<bool>(
                    value: true, // Replace with actual logic for theme preference
                    groupValue: true, // Replace with actual logic for theme preference
                    onChanged: (value) {
                      // Update theme preference in your app logic
                    },
                  ),
                  Text('Dark'),
                  Radio<bool>(
                    value: false, // Replace with actual logic for theme preference
                    groupValue: true, // Replace with actual logic for theme preference
                    onChanged: (value) {
                      // Update theme preference in your app logic
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Sync history to cloud'),
              trailing: Switch(
                value: isHistorySyncEnabled, // Use state variable
                onChanged: (value) {
                  setState(() {
                    isHistorySyncEnabled = value;
                  });
                },
              ),
            ),
            Divider(),
            //more settings
          ],
        ),
      ),
    );
  }
}