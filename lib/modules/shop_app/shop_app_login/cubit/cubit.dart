
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/modules/shop_app/shop_app_login/cubit/states.dart';
import 'package:flutter_project/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/endpoints.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) =>BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
}){
  emit(ShopLoginLoadingStates());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email':email,
        'password':password,
      }

    ).then((value){
      print(value.data);
      emit(ShopSuccessStates());
    }).catchError((error){
      emit(ShopLoginErrorStates(error.toString()));
    });



  }

  bool ispassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeVisibilty() {
     ispassword = !ispassword;
     suffix = ispassword?Icons.visibility:Icons.visibility_off;
     emit(ShopChangeVisibiltyStates());
  }

}