import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layouts/news_app/cubit/states.dart';
import 'package:flutter_project/modules/business/business_screen.dart';
import 'package:flutter_project/modules/science/science_screen.dart';
import 'package:flutter_project/modules/settings/settings_screen.dart';
import 'package:flutter_project/modules/sports/sports_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  void changeBottomItem(int index) {
    currentIndex = index;
    if (index == 1) {
      getsports();
    }
    if (index == 2) {
      getscience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'apiKey': '36479e94e45240c4b564463b32061aff',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      // print(business[0]['title']);

      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getsports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'apiKey': '36479e94e45240c4b564463b32061aff'
    }).then((value) {
      // print(value.data['articles'][0]['title']);
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];
  void getscience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'apiKey': '36479e94e45240c4b564463b32061aff'
    }).then((value) {
      // print(value.data['articles'][0]['title']);
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '36479e94e45240c4b564463b32061aff'
    }).then((value) {
      // print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
  //
  // late final WebViewController _controller;
  // void goTo({
  //   String? url,
  // }) {
  //
  // }
}

// base url : https://rickandmortyapi.com/api/character
// method (url) :v2/top-headlines?
//queries :country=eg&category=business&apikey=65f7f556ec76449fa7dc7c0069f040ca
//https://newsapi.org/v2/top-headlines?country=us&apiKey=36479e94e45240c4b564463b32061aff
