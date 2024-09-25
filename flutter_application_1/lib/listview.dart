import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Myy App"),
        ),
        body: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              width: 300,
              height: 300,
              color: Colors.green,
            ),
            Container(
            width: 300,
            height: 300,
            color: Colors.yellow,  
            ),
          ],
        )
      ),
    );
  }
}