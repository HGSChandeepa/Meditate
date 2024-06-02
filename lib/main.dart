import 'package:flutter/material.dart';
import 'package:meditation/pages/main_pages/home_page.dart';
import 'package:meditation/pages/main_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}
