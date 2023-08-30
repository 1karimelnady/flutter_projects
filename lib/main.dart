import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/help.dart';
import 'package:flutter_project/home.dart';
import 'package:flutter_project/layouts/todo_app/todo_layout.dart';
import 'package:flutter_project/shared/bloc_observer.dart';
import 'package:flutter_project/shared/network/remote/dio_helper.dart';

import 'layouts/news_app/news_layout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          textTheme: TextTheme(
            bodyMedium: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: Colors.black),
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
            type: BottomNavigationBarType.fixed,
          )),
      darkTheme: ThemeData(
        // primarySwatch: Colors.deepOrange,
        textTheme: TextTheme(
            bodyText1: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: Colors.white)),
        scaffoldBackgroundColor: Color(0xff333739),
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color(0xff33739),
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
      ),
      themeMode: ThemeMode.dark,
      home: const NewsLayout(),
      routes: {
        "home": (context) => HomeScreens(),
        "help": (context) => HelpScreen(),
      },
    );
  }
}
