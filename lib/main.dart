import 'package:flutter/material.dart';
import 'package:pbl_colormatch/screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'colormatch',
      home: HomePage(),
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
