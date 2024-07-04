import 'package:flutter/material.dart';
import 'package:QuickAttend/Themes/colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  useMaterial3: true,
  fontFamily: 'Montserrat',
  scaffoldBackgroundColor: lightBgColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.teal,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 24,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    centerTitle: true,
  ),
  colorScheme: const ColorScheme.light(
    primary: Colors.teal,
    surface: lightDivColor,
    onSurface: lightTextColor,
    secondary: buttonColor,
    onSecondary: lightColor,
    error: lightDivColor,
    onError: Colors.red,
    primaryContainer: lightDivColor,
    secondaryContainer: lightDivColor,
    onPrimaryContainer: lightTextColor,
    onSecondaryContainer: lightTextColor,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: buttonColor,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: lightColor, backgroundColor: buttonColor,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: buttonColor,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: buttonColor,
    ),
  ),
  cardTheme: const CardTheme(
    color: lightCardColor,
    shadowColor: lightDivColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: lightBorderColor),
      borderRadius: BorderRadius.circular(20.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: buttonColor),
      borderRadius: BorderRadius.circular(20.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: lightBorderColor),
      borderRadius: BorderRadius.circular(20.0),
    ),
    labelStyle: const TextStyle(color: lightLabelColor),
    hintStyle: const TextStyle(color: Colors.grey),
    filled: true,
    fillColor: Colors.grey.shade200,
    prefixIconColor: Colors.teal,
    suffixIconColor: Colors.teal,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.teal,
  useMaterial3: true,
  fontFamily: 'Montserrat',
  scaffoldBackgroundColor: darkBgColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.teal,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 24,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    centerTitle: true,
  ),
  colorScheme : const ColorScheme.dark(
    primary: Color(0xff47DED0),
    surface: darkDivColor,
    onSurface: darkTextColor,
    secondary: buttonColor,
    onSecondary: darkColor,
    error: darkDivColor,
    onError: Colors.red,
    primaryContainer: darkDivColor,
    secondaryContainer: darkDivColor,
    onPrimaryContainer: darkTextColor,
    onSecondaryContainer: darkTextColor,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: buttonColor,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: darkColor, backgroundColor: buttonColor,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: buttonColor,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: darkTextColor,
    ),
  ),
  cardTheme: const CardTheme(
    color: darkCardColor,
    shadowColor: darkDivColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: darkBorderColor),
      borderRadius: BorderRadius.circular(20.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: buttonColor),
      borderRadius: BorderRadius.circular(20.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: darkBorderColor),
      borderRadius: BorderRadius.circular(20.0),
    ),
    labelStyle: const TextStyle(color: darkLabelColor),
    hintStyle: const TextStyle(color: Colors.grey),
    filled: true,
    fillColor: Colors.grey.shade800,
    prefixIconColor: Colors.teal,
    suffixIconColor: Colors.teal,
  ),
);
