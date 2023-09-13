import 'package:flutter_project/modules/shop_app/shop_app_login/shop_login_screen.dart';
import 'package:flutter_project/shared/components/components.dart';
import 'package:flutter_project/shared/network/local/cache_helper.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1.800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateFinish(context, ShopLoginScreen());
    }
  });
}

String token = '';

String uId = '';
