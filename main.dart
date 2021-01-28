import 'package:audioplayer/home.dart';
import 'package:audioplayer/second.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "HomePage",
      routes: {
        "HomePage": (context) => HomePage(),
        "second" : (context) => second()
      },
    );
  }
}

