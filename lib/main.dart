import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/help.dart';
import 'package:flutter_project/home.dart';
import 'package:flutter_project/layouts/shop_app/cubit/cubit.dart';
import 'package:flutter_project/layouts/social_app/cubit/cubit.dart';
import 'package:flutter_project/modules/social_app/social_login/social_login_screen.dart';
import 'package:flutter_project/shared/bloc_observer.dart';
import 'package:flutter_project/shared/components/constants.dart';
import 'package:flutter_project/shared/cubit/cubit.dart';
import 'package:flutter_project/shared/cubit/states.dart';
import 'package:flutter_project/shared/network/local/cache_helper.dart';
import 'package:flutter_project/shared/network/remote/dio_helper.dart';
import 'package:flutter_project/shared/styles/styles.dart';
import 'layouts/news_app/cubit/cubit.dart';
import 'layouts/social_app/social_layout.dart';

void main() async {
  //بيتاكد ان كل حاجه في الميثود خلصت وبعدين بيرن الابليكيشن
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget? widget;
  bool isDark = CacheHelper.getData(key: 'isDark');
  dynamic? onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');
  runApp(MyApp(
    isDark: isDark,
  ));

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
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp({
    required this.isDark,
  });
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
              )),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: darktheme,
            darkTheme: lighttheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: SocialLoginScreen(),
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
