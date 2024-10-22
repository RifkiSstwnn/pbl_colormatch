import 'package:flutter/material.dart';
import 'package:pbl_colormatch/screens/home_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'colormatch',
      home: const HomePage(),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
