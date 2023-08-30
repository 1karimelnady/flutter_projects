import 'package:flutter/material.dart';
import 'package:flutter_project/one.dart';
import 'package:flutter_project/three.dart';
import 'package:flutter_project/two.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  // String? username;
  // String ? age;
  // getpref() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     username = prefs.getString("name");
  //     age = prefs.getString("age");
  //   });
  //
  // }
  String ? postion;
  String ? pos;
   getpref() async{
     SharedPreferences getpref = await SharedPreferences.getInstance();
     setState(() {
       postion = getpref.getString("position");
     });
   }
  removepref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.remove("name");
  }
  testpref() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
       pos = prefs.getString('position');
     });

  }
  List<Widget> widgetlist = [
    One(),
    Two(),
    Three(),
  ];
  int selectedindex = 0;
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          selectedindex = index;
        },
        backgroundColor: Colors.red,
        currentIndex: selectedindex,
        selectedFontSize: 30.0,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.ac_unit
              ),
              label: 'One',

          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.ac_unit
            ),
            label: 'Two',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.ac_unit
            ),
            label: 'Three',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              Text(
                '${pos}'
              ),
              ElevatedButton(
                  onPressed: () async {
                   await testpref();
                     },
                  child: Text('get pref'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
