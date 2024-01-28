import 'dart:async';
import 'package:imset_club_app/controllers/auth_controller.dart';
import 'package:imset_club_app/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final AuthController myController = Get.put(AuthController());
  bool isVerified = false;
  Timer? timer;

  @override
  void initState () {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      isVerified = currentUser.emailVerified;
      authCtr.authUser.isVerified = isVerified;
      if (!isVerified) {
        sendVerification();
        timer = Timer.periodic(const Duration(seconds: 3), (timer) => checkEmailVerified());
      }
    }
  }

  @override
  void dispose () {
    timer?.cancel();
    super.dispose();
  }

  sendVerification () async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  Future checkEmailVerified () async{
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await currentUser.reload();
      setState(() {
        isVerified = currentUser.emailVerified;
      });
      if (isVerified) {
        authCtr.currentUser.isVerified = true;
        timer?.cancel();
        Get.offAll(HomePage());
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.drafts_outlined,
                  size: 100,
                ),
                const SizedBox(height: 50),
                Center(
                  child: Text(
                    'Verify your email address',
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Text(
                    'We have just sent you an email verification link, check your inbox and click on the link to verify your email address.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                MaterialButton(
                    onPressed: (){
                      sendVerification();
                    },
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Resend Link',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
