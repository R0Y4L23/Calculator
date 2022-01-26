// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'try.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Calculator By Subham',
              style: TextStyle(color: Colors.blue.shade300),
            ),
          ),
        ),
        body: Home(),
        backgroundColor: Colors.grey.shade400,
      ),
    );
  }
}
