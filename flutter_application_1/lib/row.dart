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
        body: Row(
          children: [
            Container(
              width: 40,
              height: 200,
              color: Colors.green,
            ),
            Container(
            width: 20,
            height: 200,
            color: Colors.yellow,  
            ),
          ],
        )
      ),
    );
  }
}