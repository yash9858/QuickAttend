import 'package:QuickAttend/Student/class_select.dart';
import 'package:QuickAttend/SuperAdmin/super_admin_home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:QuickAttend/AuthPages/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';




class google extends State{
  bool loading = false;
  bool rememberMe = false;

  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> googleLogin() async {
    setState(() {
      loading = true;
    });

    try {
      await _auth.setPersistence(rememberMe ? Persistence.LOCAL : Persistence.NONE);
      SharedPreferences set = await SharedPreferences.getInstance();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await _auth.signInWithCredential(credential);
        DocumentSnapshot userDoc = await firestore.collection('users').doc(userCredential.user!.uid).get();

        if (!userDoc.exists) {
          await firestore.collection('users').doc(userCredential.user!.uid).set({
            'name': googleUser.displayName,
            'email': googleUser.email,
            'role': 'Student',
          });
        }

        if (userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
          Utils().toastMessage('Welcome, ${userData['email']}!');
          if (rememberMe) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('rememberMe', true);
            prefs.setString('email', googleUser.email);
            prefs.setString('password', googleAuth.accessToken ?? '');
          }
          if (userData['role'] == 'SuperAdmin') {
            Get.to(() => const SuperAdminHome());
          } else if (userData['role'] == 'Teacher') {
            set.setString('role', 'Teacher');
            //Get.to(() => const ClassSelect(role : 'role', StdId: UserCredential.user!.uid,));
          } else if (userData['role'] == 'Student') {
            set.setString('role', 'Student');
            //Get.to(() => const ClassSelect(role : 'role'));
          }
        }
      } else {
        Utils().toastMessage('Failed to sign in with Google');
      }
    } catch (error) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}