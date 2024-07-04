import 'package:QuickAttend/AuthPages/login_page.dart';
import 'package:QuickAttend/Themes/my_theme.dart';
import 'package:QuickAttend/Themes/theme_controller.dart';
import 'package:QuickAttend/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal,
        ),
        useMaterial3: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        )
      ),
      themeMode : themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
      home: const LoginPage(),
      darkTheme: darkTheme,
    );
  }
}

