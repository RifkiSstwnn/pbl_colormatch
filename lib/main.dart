import 'package:flutter/material.dart';
import 'package:pbl_colormatch/screens/home_screen.dart';
import 'screens/welcome_screen.dart';
import 'api_service.dart'; // Pastikan import ini sudah benar

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'colormatch',
      home: HomePage(apiService: apiService), // Pass ApiService instance
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => HomePage(apiService: apiService),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final ApiService apiService;

  HomePage({required this.apiService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter & Flask')),
      body: Center(
        child: FutureBuilder<String>(
          future: apiService.testApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return Text("Response: ${snapshot.data}");
            }
          },
        ),
      ),
    );
  }
}
