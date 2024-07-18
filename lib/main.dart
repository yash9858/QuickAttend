import 'package:QuickAttend/AuthPages/login_page.dart';
import 'package:QuickAttend/Student/student_home.dart';
import 'package:QuickAttend/SubAdmin/sub_admin_home.dart';
import 'package:QuickAttend/SuperAdmin/super_admin_home.dart';
import 'package:QuickAttend/Themes/my_theme.dart';
import 'package:QuickAttend/Themes/theme_controller.dart';
import 'package:QuickAttend/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'QuickAttend',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal,
        ),
        useMaterial3: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      themeMode: themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
      home: AuthWrapper(),
      darkTheme: darkTheme,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  Future<String?> _fetchUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        return userDoc['role'];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _fetchUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error fetching user role')),
          );
        }

        if (snapshot.hasData) {
          String? role = snapshot.data;
          if (role == 'Student') {
            return const StudentHome();
          } else if (role == 'Teacher') {
            return const SubAdminHome();
          } else if (role == 'SuperAdmin') {
            return const SuperAdminHome();
          } else {
            return const LoginPage();
          }
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
