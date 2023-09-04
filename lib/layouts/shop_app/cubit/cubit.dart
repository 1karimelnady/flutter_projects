
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layouts/shop_app/cubit/states.dart';
import 'package:flutter_project/models/shop_model/home_model.dart';
import 'package:flutter_project/modules/shop_app/categories/categories_screen.dart';
import 'package:flutter_project/modules/shop_app/favorites/favorites_screen.dart';
import 'package:flutter_project/modules/shop_app/products/products_screen.dart';
import 'package:flutter_project/shared/network/remote/dio_helper.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/endpoints.dart';

class ShopCubit extends Cubit<ShopStates> {

  ShopCubit() : super (ShopInitialStates());
  HomeModel? home_model;
  static ShopCubit get(context)=>BlocProvider.of(context);


List<Widget> bottomScreens = [
  ProductsScreen(),
  CategoriesScreen(),
  FavoritesScreen(),
  SettingsScreen()
];

  int currentIndex = 0;
  void changeBottom(int index){
    currentIndex = index;
    emit(ChangeShopBottomNavStates());
  }

  void getHomeData(){
  emit(ShopHomeLoadingStates());
    DioHelper.getData(url: Home).then((value) {
      home_model = HomeModel.fromJson(value.data);
      print(home_model?.data!.banners[0].image);
      print(home_model?.status);
      emit(ShopHomeSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopHomeErrorStates());
    });


  }

}