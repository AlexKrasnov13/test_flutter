import 'package:flutter/material.dart';

var customTheme = ThemeData(
  scaffoldBackgroundColor:  Colors.white,
  primarySwatch: Colors.blue,
  dividerColor: Colors.white24,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    backgroundColor: Color.fromARGB(158, 0, 0, 0),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  ),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.white.withOpacity(0.6),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
    headlineMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 24,
    ),
  ),
);
