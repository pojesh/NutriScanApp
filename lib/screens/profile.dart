import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/firebase/services/login_controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled1/screens/account_preferencespage.dart';
import 'package:untitled1/screens/settings_page.dart';

class Profile extends StatelessWidget {

  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    var userName = controller.googleAccount.value?.displayName ?? ' ';
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',style: GoogleFonts.lexend(),),
        backgroundColor: const Color(0xfff4f2f2),
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
                    style: GoogleFonts.lexend(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Obx(() {
                    final GoogleSignInAccount? account = controller.googleAccount.value;
                    if (account != null) {
                      return Text(
                        '${account.email}',
                        style: GoogleFonts.lexend(fontSize: 16),
                      );
                    } else {
                      return Text(
                        'Not signed in',
                        style: GoogleFonts.lexend(fontSize: 16),
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
              title: Text('My Account Preferences',style: GoogleFonts.lexend(),),
              onTap: () {
                Get.to(() => AccountPreferencesPage());
              },
            ),
            Divider(),
            // Settings section
            ListTile(
              title: Text('Settings',style: GoogleFonts.lexend(),),
              onTap: () {
                Get.to(() => SettingsPage());
              },
            ),
            Divider(),
            // Refer and Earn section
            ListTile(
              title: Text('Refer and Earn Program',style: GoogleFonts.lexend(),),
              onTap: () {
                // Add navigation logic here
              },
            ),
            Divider(),
            // Help section
            ListTile(
              title: Text('Help',style: GoogleFonts.lexend(),),
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