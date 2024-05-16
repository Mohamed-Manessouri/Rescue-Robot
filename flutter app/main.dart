import 'package:flutter/material.dart';
import 'firstpage.dart';
import 'secondpage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirstPage(),
        routes: {
          '/secondpage': (context) => SecondPage(),
        }
    );
  }

}

