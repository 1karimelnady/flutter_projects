import 'package:flutter_project/models/shop_model/change_favorite_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ChangeShopBottomNavStates extends ShopStates {}

class ShopHomeLoadingStates extends ShopStates {}

class ShopHomeSuccessStates extends ShopStates {}

class ShopHomeErrorStates extends ShopStates {}

class ShopCategoriesSuccessStates extends ShopStates {}

class ShopCategoriesErrorStates extends ShopStates {}

class ShopChangeFavoriteStates extends ShopStates {}

class ShopFavoriteLoadingStates extends ShopStates {}

class ShopChangeFavoriteSuccessStates extends ShopStates {

  final ChangeFavoriteModel model;
  ShopChangeFavoriteSuccessStates(this.model);
}

class ShopChangeFavoriteErrorStates extends ShopStates {}

class ShopFavoritesSuccessStates extends ShopStates {}

class ShopFavoritesErrorStates extends ShopStates {}

class ShopGetUserDataLoadingStates extends ShopStates {}

class ShopGetUserDataSuccessStates extends ShopStates {}

class ShopGetUserDataErrorStates extends ShopStates {}