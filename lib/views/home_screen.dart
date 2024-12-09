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

  double _calculateWidth(String title) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width + 16;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 0),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
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
    double iconWidth = isSelected ? _calculateWidth(_titles[index]) : 60;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: iconWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF235F60) : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              icon,
              size: 26,
              color: isSelected ? Color(0xffb1e33d) : Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Text(
              _titles[index],
              style: TextStyle(
                color: isSelected ? Colors.grey : Colors.grey,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
