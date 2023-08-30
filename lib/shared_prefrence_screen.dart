import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefrence extends StatefulWidget {


  @override
  State<SharedPrefrence> createState() => _SharedPrefrenceState();
}

class _SharedPrefrenceState extends State<SharedPrefrence> {
  savepref () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", "karim");
    prefs.setString("age", "22");
  }

  studdata() async {
    SharedPreferences studpref = await SharedPreferences.getInstance();
    studpref.setString("position", "flutter devloper");
  }

  savpref() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("position", "flutter developer");
  }

  List<String> items = [
    'Male',
    'Female'
  ];

  String selectemvalue = "Male";

  GlobalKey<ScaffoldState> scafoldkey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
          onPressed: () async{
            await savpref() ;
            },
            child: Icon(
              Icons.add,
            ),
      ),
      appBar: AppBar(
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Karim Elnady"),
              accountEmail: Text("karimelnady@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text("IMAGE"),
              ),


            ),
            ListTile(
              leading: IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.home_filled
                ),
              ),
              title:Text("HOME"),

            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            ElevatedButton(
              onPressed: () async {
                await savpref();
              },
              child: Text('save pref',style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: ()  {
                Navigator.pushNamed(context, "test");
              },
              child: Text('go to sharaed'),
            ),
            SizedBox(height: 80.0,),
            DropdownButton(
              value:selectemvalue ,
                items: items.map((e){
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (String ? newvalue){
                  setState(() {
                    selectemvalue = newvalue!;
                  });
                }
            )

          ],
        ),
      ),
    );
  }
}
