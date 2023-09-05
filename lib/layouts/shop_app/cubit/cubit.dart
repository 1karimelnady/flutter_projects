
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layouts/shop_app/cubit/states.dart';
import 'package:flutter_project/models/shop_model/categories_model.dart';
import 'package:flutter_project/models/shop_model/change_favorite_model.dart';
import 'package:flutter_project/models/shop_model/favorite_model.dart';
import 'package:flutter_project/models/shop_model/home_model.dart';
import 'package:flutter_project/models/shop_model/login_model.dart';
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
  CategoriesModel? categoriesModel;
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


  Map<int,bool> favorite = {};


  void getHomeData(){
  emit(ShopHomeLoadingStates());
    DioHelper.getData(url: Home).then((value) {
      home_model = HomeModel.fromJson(value.data);
      print(home_model?.data!.banners[0].image);
      print(home_model?.status);

      home_model!.data!.products.forEach((element) {
        favorite.addAll({
          element.id!:element.in_favorites!
        });
      });

      emit(ShopHomeSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopHomeErrorStates());
    });


  }

  void getCategories(){
    DioHelper.getData(
        url: Get_categories
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopCategoriesErrorStates());
    });


  }

  ChangeFavoriteModel? changeFavoriteModel;

  void ChangeFavorite (int product_id){
    favorite[product_id]=!favorite[product_id]!;
    emit(ShopChangeFavoriteStates());
    DioHelper.postData(
        url: changeFavorite,
        token: token,
        data: {
          'product_id':product_id
        }
    ).then((value){
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if(!changeFavoriteModel!.status!){
        favorite[product_id]=!favorite[product_id]!;
      }else{
        getFavorites();
      }
      emit(ShopChangeFavoriteSuccessStates(changeFavoriteModel!));
    }).catchError((error){
      print(error.toString());
      favorite[product_id]=!favorite[product_id]!;
      emit(ShopChangeFavoriteErrorStates());
    });

  }

  FavoritesModel? favoritesModel;

  void getFavorites()
  {
    emit(ShopFavoriteLoadingStates());

    DioHelper.getData(url: changeFavorite, token: token).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(ShopFavoritesSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopFavoritesErrorStates());
    });
  }

  ShopLoginModel? userModel;

  void getUserData()
  {
    emit(ShopGetUserDataLoadingStates());

    DioHelper.getData(url: Profile, token: token).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopGetUserDataSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetUserDataErrorStates());
    });
  }



}
  // FavoriteModel? favoriteModel;
  // void getFavorite(){
  //   DioHelper.getData(
  //       url: changeFavorite
  //   ).then((value){
  //     favoriteModel = FavoriteModel.fromJson(value.data);
  //     emit(ShopFavoritesSuccessStates());
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(ShopFavoritesErrorStates());
  //   });
