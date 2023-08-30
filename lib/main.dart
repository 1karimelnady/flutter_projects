import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/help.dart';
import 'package:flutter_project/home.dart';
import 'package:flutter_project/layouts/todo_app/todo_layout.dart';
import 'package:flutter_project/shared/bloc_observer.dart';
import 'package:flutter_project/shared/cubit/cubit.dart';
import 'package:flutter_project/shared/cubit/states.dart';
import 'package:flutter_project/shared/network/local/cache_helper.dart';
import 'package:flutter_project/shared/network/remote/dio_helper.dart';

import 'layouts/news_app/cubit/cubit.dart';
import 'layouts/news_app/news_layout.dart';

void main() async {
  //بيتاكد ان كل حاجه في الميثود خلصت وبعدين بيرن الابليكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => NewsCubit()
              ..getBusiness()
              ..getsports()
              ..getscience()),
        BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..changeMode(
                fromshared: isDark,
              ))
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                textTheme: const TextTheme(
                  bodyLarge: TextStyle(
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
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                )),
            darkTheme: ThemeData(
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: Colors.white),
              ),
              scaffoldBackgroundColor: const Color(0xff333739),
              appBarTheme: const AppBarTheme(
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color(0xff333739),
                    statusBarIconBrightness: Brightness.light),
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
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
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const NewsLayout(),
            routes: {
              "home": (context) => HomeScreens(),
              "help": (context) => HelpScreen(),
            },
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
//
// BlocProvider(
//   create: (BuildContext context) => NewsCubit()..getBusiness() ..getsports()..getscience(),),
// BlocProvider(
// create: (BuildContext context) => AppCubit()..changeMode(fromshared: isDark,),)
