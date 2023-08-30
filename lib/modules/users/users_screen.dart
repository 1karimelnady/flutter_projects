import 'package:flutter/material.dart';
import 'package:flutter_project/models/users/user.dart';

class UsersScreen extends StatelessWidget {
 List<usermodel> users =[
   usermodel(id: 1, name: "karim", phone: "+201030536167"),
   usermodel(id: 2, name: "youssef", phone: "+201030536167"),
   usermodel(id: 3, name: "mostafa", phone: "+201030536167"),
 ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(
            'users',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: ListView.separated(
              itemBuilder: (context,index)=>user(users[index]),
              separatorBuilder: (context,index)=>Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 20.0
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              itemCount: users.length
          ),

    );
  }
  Widget user(usermodel user)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.blue,
          child: Text(
            '${user.id}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
        ),
        SizedBox(width: 20.0,),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${user.name}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.black
              ),
            ),
            Text(
              "${user.phone}",
              style: TextStyle(
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),

      ],

    ),
  );
}