import 'package:imset_club_app/auth/login_page.dart';
import 'package:imset_club_app/auth/verify_page.dart';
import 'package:imset_club_app/controllers/auth_controller.dart';
import 'package:imset_club_app/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (authCtr.authUser.isVerified!) {
              return HomePage();
            } else {
              return VerifyPage();
            }
          }
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
