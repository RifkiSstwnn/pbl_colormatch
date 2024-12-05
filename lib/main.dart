import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/history_provider.dart';
import '../models/history_model.dart';
import 'services/user_service.dart';
import 'views/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ColorMatch',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAndGenerateUUID();
  }

  Future<void> _checkAndGenerateUUID() async {
    try {
      await Future.delayed(
          const Duration(seconds: 2)); // Delay untuk splash screen

      if (!mounted) return;
      final prefs = await SharedPreferences.getInstance();
      String? uuid = prefs.getString('userUUID');
      UserService userService = UserService();

      if (uuid == null) {
        // Generate UUID jika belum ada
        uuid = const Uuid().v4();
        await prefs.setString('userUUID', uuid);
        print('New UUID generated: $uuid');
        // Tambahkan user baru ke server
        User newUser = User(uuid: uuid);
        await userService.addUser(newUser);
      } else {
        await userService.cekUser(uuid);
      }
      if (!mounted) return;

      // Menggunakan named route untuk navigasi
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      print('Error in _checkAndGenerateUUID: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Image.asset(
  //             'assets/logo1.png', // Use your logo image path
  //             height: 100, // Adjust height as needed
  //           ),
  //           // const SizedBox(height: 50),
  //           const CircularProgressIndicator(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFF235F60)), // Custom color
            ),
          ],
        ),
      ),
    );
  }
}

// Contoh implementasi halaman-halaman lain
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Page')),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('Profile Page')),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: const Center(child: Text('Favorites Page')),
    );
  }
}
