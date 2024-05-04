import 'package:flutter/material.dart';
import 'package:untitled1/firebase/services/login_controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profile extends StatelessWidget {

  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    var userName = controller.googleAccount.value?.displayName ?? ' ';
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Obx(() {
                    final GoogleSignInAccount? account = controller.googleAccount.value;
                    if (account != null) {
                      return Text(
                        '${account.email}',
                        style: TextStyle(fontSize: 16),
                      );
                    } else {
                      return Text(
                        'Not signed in',
                        style: TextStyle(fontSize: 16),
                      );
                    }
                  }),
                  SizedBox(height: 8.0),
                  Divider(thickness: 2.0),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
            // Account preferences section
            ListTile(
              title: Text('My Account Preferences'),
              onTap: () {
                // Add navigation logic here
              },
            ),
            Divider(),
            // Settings section
            ListTile(
              title: Text('Settings'),
              onTap: () {
                // Add navigation logic here
              },
            ),
            Divider(),
            // Refer and Earn section
            ListTile(
              title: Text('Refer and Earn Program'),
              onTap: () {
                // Add navigation logic here
              },
            ),
            Divider(),
            // Help section
            ListTile(
              title: Text('Help'),
              onTap: () {
                // Add navigation logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}