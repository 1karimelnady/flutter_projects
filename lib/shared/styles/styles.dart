import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors/colors.dart';

ThemeData darktheme = ThemeData(
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
        fontWeight: FontWeight.w500, fontSize: 18.0, color: Colors.white),
  ),
  scaffoldBackgroundColor: const Color(0xff333739),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xff333739),
        statusBarIconBrightness: Brightness.light),
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Color(0xff333739),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    backgroundColor: Color(0xff333739),
    type: BottomNavigationBarType.fixed,
  ),
);
ThemeData lighttheme = ThemeData(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 18.0, color: Colors.black),
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
    ));
