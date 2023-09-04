import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/shared/cubit/cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/news_app/web_view/web_view_screen.dart';
import '../../modules/shop_app/shop_app_login/shop_login_screen.dart';
import '../styles/colors/colors.dart';

Widget defaultbutton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: 60.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );
defaultformfield({
  required TextEditingController textEditingController,
  required TextInputType textInputType,
  required String label,
  bool ispassword = false,
  IconData? perfix,
  IconData? suffix,
  VoidCallback? suffixpressed,
  VoidCallback? ontap,
  FormFieldValidator<String>? onChange,
  required FormFieldValidator<String>? validator,
}) =>
    TextFormField(
        controller: textEditingController,
        keyboardType: textInputType,
        validator: validator,
        onFieldSubmitted: (String value) {
          print(value);
        },
        onChanged: onChange,
        onTap: ontap,
        obscureText: ispassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(perfix),
          suffixIcon: IconButton(
            icon: Icon(suffix),
            onPressed: suffixpressed,
          ),
          labelText: label,
        ));

Widget customtasks(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).DeleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text('02:00 pm'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .UpdateData(status: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .UpdateData(status: 'archive', id: model['id']);
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );

Widget builderTasks({required List<Map> tasks}) => ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) => ListView.separated(
        itemBuilder: (context, index) => customtasks(tasks[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length),
    fallback: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu,
                size: 70,
                color: Colors.grey,
              ),
              Text(
                'No Tasks Yet, Please Add Some Tasks',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(url: article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage("${article['urlToImage']}"),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
Widget articleBuilder(list, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      ),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        color: Colors.grey[300],
        width: double.infinity,
        height: 1,
      ),
    );
void navigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void navigateFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(
      builder: (context) => Widget),
      (Route<dynamic> route)=>false
);

Widget defalutTextButton({
  String ?context,
  required String text,
  required VoidCallback function,
})=>TextButton(
  onPressed: function,
  child: Text(
    '$text',
    style: TextStyle(
        color: primarycolor,
        fontWeight: FontWeight.bold,
        fontSize: 18
    ),
  ),
);

void showToast({
  required String text,
  required ToastStates state
})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates stata){
  Color color;
  switch(stata){
    case ToastStates.SUCCESS :
      color = Colors.green;
      break;
    case ToastStates.ERROR :
      color = Colors.red;
      break;
    case ToastStates.WARNING :
      color = Colors.amber;
      break;
  }
  return color;
}