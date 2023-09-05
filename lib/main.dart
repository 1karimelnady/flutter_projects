import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/help.dart';
import 'package:flutter_project/home.dart';
import 'package:flutter_project/layouts/shop_app/cubit/cubit.dart';
import 'package:flutter_project/layouts/shop_app/shop_layout.dart';
import 'package:flutter_project/modules/shop_app/shop_app_login/shop_login_screen.dart';
import 'package:flutter_project/shared/bloc_observer.dart';
import 'package:flutter_project/shared/components/constants.dart';
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
  Widget? widget;
  dynamic? isDark = CacheHelper.getData(key: 'isDark');
  dynamic? onBoarding = CacheHelper.getData(key: 'onBoarding');
     // token = CacheHelper.getData(key: 'token');
  // if(onBoarding!=null){
  //   if(token!=null){
  //     widget = ShopLayout();
  //   }else {
  //     widget = ShopLoginScreen();
  //   }
  // }else {
  //   widget = OnBoardingScreen();
  // }
  runApp(MyApp(
    isDark,
    widget,
  ));
}

class MyApp extends StatelessWidget {
  final dynamic isDark;
  final dynamic startWidget;
  MyApp(this.isDark, this.startWidget);
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
              )
        ),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: darktheme,
            darkTheme: lighttheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
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