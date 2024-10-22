import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:pbl_colormatch/screens/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Selamat Datang di colormatch',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          OpenContainer(
            transitionDuration: const Duration(seconds: 1),
            closedBuilder: (context, action) => ElevatedButton(
              onPressed: action,
              child: const Text('Berikutnya'),
            ),
            openBuilder: (context, action) => HomePage(),
          ),
        ],
      ),
    );
  }
}
