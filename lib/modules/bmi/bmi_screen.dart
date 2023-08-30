import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_project/modules/bmi_result/bmi_result_screen.dart';

class BMIScreen extends StatefulWidget {
  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  bool ismale = true;
  double height = 150;
  int age = 20;
  double weight = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator'
        ),
      ),
      body: Column(
        children:
        [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            ismale = true;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(5.0),
                            color: ismale ? Colors.blue : Colors.grey[300]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children:
                              [
                                Image(
                                  image: AssetImage("assets/images/images.png"),
                                  width: 90.0,
                                    height: 90.0,
                                ),
                                SizedBox(height: 5.0,),
                                Text(
                                    'MALE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            ismale = false;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(5.0),
                              color: !ismale ? Colors.blue : Colors.grey[300]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children:
                              [
                                Image(
                                  image: AssetImage("assets/images/images (1).png"),
                                  width: 90.0,
                                  height: 90.0,
                                ),
                                SizedBox(height: 5.0,),
                                Text(
                                  'FEMALE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    fontSize: 25.0
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(5.0),
                  color: Colors.grey[300]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Text(
                      'HEIGHT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children:
                      [
                        Text(
                          '${height.round()}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0
                          ),
                        ),
                        Text(
                          'cm',
                          style: TextStyle(
                            fontSize: 20.0
                          ),
                        ),
                      ],
                    ),
                    Slider(
                        value: height,
                        max: 300,
                        min: 80,
                        onChanged: (value){
                          setState(() {
                            height = value;
                          });
                        }
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(5.0),
                          color: Colors.grey[300]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              'Age',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0
                              ),
                            ),
                            Text(
                              '$age',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              [
                                FloatingActionButton(

                                  onPressed: (){
                                    setState(() {
                                      age++;
                                    });
                                  },
                                  mini: true,
                                  child: Icon(
                                      Icons.add
                                  ),
                                ),
                                SizedBox(width: 10.0,),
                                FloatingActionButton(

                                  onPressed: (){
                                    setState(() {
                                      age--;
                                    });
                                  },
                                  mini: true,
                                  child: Icon(
                                      Icons.remove
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(5.0),
                          color: Colors.grey[300]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              'Weight',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0
                              ),
                            ),
                            Text(
                              '$weight',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              [
                                FloatingActionButton(

                                  onPressed: (){
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                  mini: true,
                                  child: Icon(
                                      Icons.add
                                  ),
                                ),
                                SizedBox(width: 10.0,),
                                FloatingActionButton(
                                  onPressed: (){
                                    setState(() {
                                      weight--;
                                    });
                                  },
                                  mini: true,
                                  child: Icon(
                                      Icons.remove
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: MaterialButton(
              onPressed: (){
                double result = weight/ pow(height/180,2);
                print(result.round());
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>BmiResultScreen(
                      age: age,
                      ismale: ismale,
                      result: result.round(),
                    )
                ),
                );
              },
              child: Text(
                'Calculate',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
