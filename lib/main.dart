import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'services/user_service.dart'; // Import service user
import 'views/home_screen.dart'; // Import home screen

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/', // Initial route
      routes: {
        '/': (context) => const SplashScreen(), // Splash Screen
        '/home': (context) => HomePage(), // Home Page
      },
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
    _checkAndGenerateUUID(); // Panggil fungsi pengecekan UUID
  }

  // Fungsi untuk mengecek atau generate UUID
  Future<void> _checkAndGenerateUUID() async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // Delay splash screen

      if (!mounted) return; // Cek jika widget masih dipasang
      final prefs = await SharedPreferences.getInstance();
      String? uuid =
          prefs.getString('userUUID'); // Ambil UUID dari local storage
      UserService userService = UserService();

      if (uuid == null) {
        // Generate UUID jika belum ada
        uuid = const Uuid().v4();
        await prefs.setString(
            'userUUID', uuid); // Simpan UUID di SharedPreferences
        print('New UUID generated: $uuid');

        // Tambahkan user baru ke server (jika diperlukan)
        User newUser = User(uuid: uuid);
        await userService.addUser(newUser);
      } else {
        // Cek user UUID di server
        await userService.cekUser(uuid);
        print('UUID found: $uuid');
      }

      if (!mounted) return;

      // Navigasi ke HomePage
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      print('Error in _checkAndGenerateUUID: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Colormatch',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 66, 170, 255)),
            ),
          ],
        ),
      ),
    );
  }
}
