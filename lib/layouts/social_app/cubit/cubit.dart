import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layouts/social_app/cubit/states.dart';
import 'package:flutter_project/models/social_model/social_user_model.dart';
import 'package:flutter_project/modules/social_app/chats/chats_screen.dart';
import 'package:flutter_project/modules/social_app/feeds/feeds_screen.dart';
import 'package:flutter_project/modules/social_app/new_post/new_post_sreen.dart';
import 'package:flutter_project/modules/social_app/settings/settings_screen.dart';
import 'package:flutter_project/modules/social_app/users/users.dart';
import 'package:flutter_project/shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData() {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    usersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];

  int currentIndex = 0;
  void changeBottom(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }
}
