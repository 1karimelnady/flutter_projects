import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedindex,
        selectedItemColor: Colors.green,
        selectedLabelStyle: TextStyle(fontSize: 25.0),
        onTap: (index) {
          setState(() {
            selectedindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.ac_unit),
          ),
          BottomNavigationBarItem(
            label: 'Help',
            icon: Icon(Icons.help),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
