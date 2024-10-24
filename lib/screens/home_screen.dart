import 'package:flutter/material.dart';
import 'info_screen.dart';
import 'camera_screen.dart';
import 'palette_screen.dart';
import 'history_screen.dart'; // Impor HistoryScreen

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HistoryScreen(),
    CameraScreen(),
    PaletteScreen(),
    InfoScreen(),
  ]; // Tambahkan HistoryScreen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 182, 182, 182).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index; // Update index saat item ditekan
              });
            },
            selectedItemColor: Colors.blue, // Warna untuk item yang dipilih
            unselectedItemColor:
                Colors.grey, // Warna untuk item yang tidak dipilih
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.history, size: 35),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera, size: 35),
                label: 'Camera',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.palette, size: 35),
                label: 'Palette',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info, size: 35),
                label: 'Info',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
