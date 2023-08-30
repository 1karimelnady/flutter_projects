import 'package:flutter/material.dart';

class DesignScreen extends StatefulWidget {
  @override
  State<DesignScreen> createState() => _DesignScreenState();

}
class _DesignScreenState extends State<DesignScreen> {
  int selectedvalue = 0;
  bool isrtl = true;
  GlobalKey<ScaffoldState> formkey = new GlobalKey();
   changeltr(){
    Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
          setState(() {
            selectedvalue = value;
          });
        },
        currentIndex: selectedvalue,
        selectedItemColor: Colors.blue,
        selectedFontSize: 20.0,
        unselectedFontSize: 20.0,
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: IconButton(
                icon: Icon(
                    Icons.home,
                  color: Color(0xff09090f),
                ),
                onPressed: (){
                  Navigator.pushNamed(context, "home");
                },
              )
          ),
          BottomNavigationBarItem(
              label: 'Help',
              icon: IconButton(
                icon: Icon(
                    Icons.help
                ),
                onPressed: (){
                  Navigator.pushNamed(context, "help");
                },
              )

          ),

        ],
      ),
    );
  }
@override
  void initState() {
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      key: formkey,
      drawer: Drawer(
        child: Column(
          children:
          [
            UserAccountsDrawerHeader(
                accountName: Text('karim'),
                accountEmail: Text('karimelnady728@gmail.com')
            )
          ],
        ),
      ),
      endDrawer:Drawer(
        child: Column(
          children:
          [
            UserAccountsDrawerHeader(
                accountName: Text('karim'),
                accountEmail: Text('karimelnady728@gmail.com')
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
          setState(() {
            selectedvalue = value;
          });
        },
        currentIndex: selectedvalue,
        selectedItemColor: Colors.blue,
        selectedFontSize: 20.0,
        unselectedFontSize: 20.0,
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: IconButton(
                icon: Icon(
                    Icons.home
                ),
                onPressed: (){
                  Navigator.pushNamed(context, "home");
                },
              )
          ),
          BottomNavigationBarItem(
              label: 'Help',
              icon: IconButton(
                icon: Icon(
                    Icons.help
                ),
                onPressed: (){
                  Navigator.pushNamed(context, "help");
                },
              )

          ),

        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            MaterialButton(
              child: Text(
                'Help',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue
                ),
              ),
              onPressed: (){
                isrtl? formkey.currentState?.openDrawer():formkey.currentState?.openEndDrawer();
              },
            ),
          ],
        ),
      ),
    );
  }
}
