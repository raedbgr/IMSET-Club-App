import 'package:imset_club_app/controllers/auth_controller.dart';
import 'package:imset_club_app/home/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  final AuthController myController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Home',),
        backgroundColor: Colors.grey.shade900,
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey.shade900,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            DrawerHeader(
                child: Icon(Icons. person, size: 120, color: Colors.grey.shade200,)
            ),
            const SizedBox(height: 100,),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Icon(Icons.account_circle_outlined, color: Colors.grey.shade200, size: 25,),
                      title: Text('PROFILE', style: TextStyle(color: Colors.grey.shade200, fontSize: 15),),
                      onTap: () {
                        Get.to(Profile());
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.grey.shade200, size: 25,),
                      title: Text('LOGOUT', style: TextStyle(color: Colors.grey.shade200, fontSize: 15),),
                      onTap: () async {
                        showDialog(context: context, builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                        await FirebaseAuth.instance.signOut();
                        Get.back();
                        Get.to(LoginPage());
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Logged in as ',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  Text(
                    user!.email!,
                    style: TextStyle(
                        color: Colors.grey.shade800, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
