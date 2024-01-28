import 'package:imset_club_app/Models/user.dart';
import 'package:imset_club_app/auth/verify_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AuthController get authCtr => Get.find<AuthController>();
class AuthController extends GetxController {
  List<userModel> userList = <userModel>[];
  userModel currentUser = userModel();
  userModel authUser = userModel();
  final user = FirebaseAuth.instance.currentUser;

  signUp(String name, String emailAddress, String phone, String password, ctx) async {

    showDialog(
        context: ctx,
        builder: (_) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      User? userCred = userCredential.user;
      await userCred?.sendEmailVerification();

      CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

      usersRef.add({
        'uid': usersRef.id,
        'name': name,
        'email': emailAddress,
        'pwd': password,
        'phone': phone,
        'role': 'member',
        'isVerfied': false,
      });

      currentUser.uid = usersRef.id;
      currentUser.name = name;
      currentUser.email = emailAddress;
      currentUser.pwd = password;
      currentUser.phone = phone;
      currentUser.role = 'member';
      currentUser.isVerified = false;
      userList.add(currentUser);

      Get.back();
      Get.to(VerifyPage());

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const snackBar = SnackBar(content: Text('The password provided is too weak.'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
        Get.back();
      } else if (e.code == 'email-already-in-use') {
        const snackBar = SnackBar(content: Text('An account already exists for that email.'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
        Get.back();
      }else {
        const snackBar = SnackBar(content: Text('Unknown Error.'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
        Get.back();
      }
    } catch (e) {
      print(e);
    }
  }

  signIn(String emailAddress, String password, ctx) async {
    showDialog(
        context: ctx,
        builder: (_) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        const snackBar = SnackBar(content: Text('No user found for that email.'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        const snackBar = SnackBar(content: Text('Wrong password provided for that user.'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      }else {
        const snackBar = SnackBar(content: Text('Email provided is unavailable.'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      }
    }

    Get.back();
  }

  Future resetPasswrd (String emailAddress, ctx, controller) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
      showDialog(
        context: ctx,
        builder: (ctx) {
          return const AlertDialog(
            content: Text('Password reset link sent to your email'),
          );
        },
      );
      controller.clear();
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }
  }

  // Function to fetch user data from Firestore and convert it to userModel
  void fetchUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(currentUser.email).get();

      if (snapshot.exists) {
          // Convert the document data to userModel
          authUser = userModel.fromJson(snapshot.data()!);
          update();
      }
    }
  }

}
