import 'package:QuickAttend/Student/class_select.dart';
import 'package:QuickAttend/SuperAdmin/super_admin_home.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:QuickAttend/AuthPages/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class apple extends State{
  bool loading = false;
  bool rememberMe = false;

  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> appleLogin() async {
    await _auth.setPersistence(rememberMe ? Persistence.LOCAL : Persistence.NONE);
    setState(() {
      loading = true;
    });

    try {
      SharedPreferences set = await SharedPreferences.getInstance();
      final AuthorizationCredentialAppleID appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final AuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      DocumentSnapshot userDoc = await firestore.collection('users').doc(userCredential.user!.uid).get();

      if (!userDoc.exists) {
        await firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': "${appleCredential.givenName} ${appleCredential.familyName}",
          'email': appleCredential.email,
          'role': 'Student', // default role, change as needed
        });
      }

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        Utils().toastMessage('Welcome, ${userData['email']}!');
        if (rememberMe) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('rememberMe', true);
          prefs.setString('email', appleCredential.email ?? '');
          prefs.setString('password', appleCredential.authorizationCode);
        }
        if (userData['role'] == 'SuperAdmin') {
          Get.to(() => const SuperAdminHome());
        } else if (userData['role'] == 'Teacher') {
          set.setString('role', 'Teacher');
          //Get.to(() => const ClassSelect(role : 'role'));
        } else if (userData['role'] == 'Student') {
          set.setString('role', 'Teacher');
          //Get.to(() => const ClassSelect(role : 'role'));
        }
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