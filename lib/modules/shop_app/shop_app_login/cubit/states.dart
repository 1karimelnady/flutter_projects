
abstract class ShopLoginStates {}

 class ShopLoginInitialStates extends ShopLoginStates {}

 class ShopLoginLoadingStates extends ShopLoginStates {}

 class ShopSuccessStates extends ShopLoginStates {}

 class ShopLoginErrorStates extends ShopLoginStates {
 final error;
 ShopLoginErrorStates(this.error);
 }

class ShopChangeVisibiltyStates extends ShopLoginStates {}