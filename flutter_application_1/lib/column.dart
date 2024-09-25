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
        body: Column(
          children: [
            Container(
              width: 200,
              height: 30,
              color: Colors.green,
            ),
            Container(
            width: 200,
            height: 40,
            color: Colors.yellow,  
            ),
          ],
        )
      ),
    );
  }
}