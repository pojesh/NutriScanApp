import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Preferences'),
      ),
      body: ListView(
        children: [
          // Edit profile information
          ListTile(
            title: Text('Edit Profile'),
            onTap: () {
              // Navigate to edit profile screen (if applicable)
            },
          ),
          Divider(),
          // Change password
          ListTile(
            title: Text('Change Password'),
            onTap: () {
              // Navigate to change password screen (if applicable)
            },
          ),
          Divider(),
          // Manage payment methods
          ListTile(
            title: Text('Manage Payment Methods'),
            onTap: () {
              // Navigate to manage payment methods screen (if applicable)
            },
          ),
          Divider(),
          // More account preference options...
        ],
      ),
    );
  }
}