import 'package:flutter/material.dart';

class HomeScreens extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children:
          [
            Text(
              'Welcome from Home Page',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25.0,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
