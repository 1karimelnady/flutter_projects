import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/help.dart';
import 'package:flutter_project/home.dart';
import 'package:flutter_project/shared/bloc_observer.dart';
import 'package:flutter_project/shared/cubit/cubit.dart';
import 'package:flutter_project/shared/cubit/states.dart';
import 'package:flutter_project/shared/network/local/cache_helper.dart';
import 'package:flutter_project/shared/network/remote/dio_helper.dart';
import 'package:flutter_project/shared/styles/styles.dart';

import 'layouts/news_app/cubit/cubit.dart';
import 'layouts/news_app/news_layout.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

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
            theme: darktheme,
            darkTheme: lighttheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: OnBoardingScreen(),
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
