import 'package:flutter/material.dart';
import 'info_screen.dart';
import 'camera_screen.dart';
import 'palette_screen.dart';
import 'history_screen.dart';

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
  ];

  final List<String> _titles = [
    'History',
    'Camera',
    'Palette',
    'Info',
  ];

  final List<IconData> _icons = [
    Icons.history,
    Icons.camera_alt,
    Icons.palette,
    Icons.info,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: List.generate(4, (index) {
              return BottomNavigationBarItem(
                icon: _buildBottomNavIcon(_icons[index], index),
                label: '',
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavIcon(IconData icon, int index) {
    bool isSelected = _currentIndex == index;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isSelected ? 80 : 60,
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF235F60) : Colors.transparent,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        // New container for padding
        padding: EdgeInsets.symmetric(vertical: 4.0), // Add vertical padding
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Color(0xffb1e33d) : Colors.grey,
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  _titles[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
