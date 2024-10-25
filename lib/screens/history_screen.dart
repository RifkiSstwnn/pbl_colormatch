import 'package:flutter/material.dart';
import 'detail_history_screen.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 90.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 30, bottom: 16.0),
              title: Text(
                'Scan History',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
            ),
            pinned: false,
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: _buildImageContainer(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Nama pengguna yang akan ditampilkan
                final String users = 'Alice';

                // Menentukan warna untuk masing-masing musim
                List<Color> skinColors, eyeColors, eyebrowColors, bestColors;

                if (index == 0) { // Summer
                  skinColors = [
                    const Color(0xFFF8E8D0),
                    const Color(0xFFD2B49C),
                    const Color(0xFF8D5524)];
                  eyeColors = [const Color(0xFF3E2C1C), const Color(0xFF8B4513)];
                  eyebrowColors = [
                    const Color(0xFFCD853F),
                    const Color(0xFF8B4513),
                    const Color(0xFF3E2C1C)];
                  bestColors = [
                    const Color(0xFFE6AC27),
                    const Color(0xFF4682B4),
                    const Color(0xFF8A2BE2),
                    const Color(0xFF006400),
                    const Color(0xFFD2691E),
                    const Color(0xFF32CD32),
                    const Color(0xFF4682B4),
                  const Color(0xFF6A5ACD),];
                } else if (index == 1) { // Autumn
                  skinColors = [
                    const Color(0xFFF8E8D0),
                    const Color(0xFFD2B49C),
                    const Color(0xFF8D5524)];
                  eyeColors = [const Color(0xFF3E2C1C), const Color(0xFF8B4513)];
                  eyebrowColors = [
                    const Color(0xFFCD853F),
                    const Color(0xFF8B4513),
                    const Color(0xFF3E2C1C)];
                  bestColors = [
                    const Color(0xFFE6AC27),
                    const Color(0xFF4682B4),
                    const Color(0xFF8A2BE2),
                    const Color(0xFF006400),
                    const Color(0xFFD2691E),
                    const Color(0xFF32CD32),
                    const Color(0xFF4682B4),
                  const Color(0xFF6A5ACD),];
                } else if (index == 2) { // Winter
                  skinColors = [
                    const Color(0xFFF8E8D0),
                    const Color(0xFFD2B49C),
                    const Color(0xFF8D5524)];
                  eyeColors = [const Color(0xFF3E2C1C), const Color(0xFF8B4513)];
                  eyebrowColors = [
                    const Color(0xFFCD853F),
                    const Color(0xFF8B4513),
                    const Color(0xFF3E2C1C)];
                  bestColors = [
                    const Color(0xFFE6AC27),
                    const Color(0xFF4682B4),
                    const Color(0xFF8A2BE2),
                    const Color(0xFF006400),
                    const Color(0xFFD2691E),
                    const Color(0xFF32CD32),
                    const Color(0xFF4682B4),
                  const Color(0xFF6A5ACD),];
                } else { // Spring
                  skinColors = [
                    const Color(0xFFF8E8D0),
                    const Color(0xFFD2B49C),
                    const Color(0xFF8D5524)];
                  eyeColors = [const Color(0xFF3E2C1C), const Color(0xFF8B4513)];
                  eyebrowColors = [
                    const Color(0xFFCD853F),
                    const Color(0xFF8B4513),
                    const Color(0xFF3E2C1C)];
                  bestColors = [
                    const Color(0xFFE6AC27),
                    const Color(0xFF4682B4),
                    const Color(0xFF8A2BE2),
                    const Color(0xFF006400),
                    const Color(0xFFD2691E),
                    const Color(0xFF32CD32),
                    const Color(0xFF4682B4),
                  const Color(0xFF6A5ACD),];
                }

                return InkWell(
                  onTap: () {
                    // Navigasi ke halaman detail dengan mengirimkan data warna
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailHistoryScreen(
                          season: index == 0
                              ? 'Summer'
                              : index == 1
                                  ? 'Autumn'
                                  : index == 2
                                      ? 'Winter'
                                      : 'Spring',
                          skinColors: skinColors,
                          eyeColors: eyeColors,
                          eyebrowColors: eyebrowColors,
                          bestColors: bestColors,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 140,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 245, 245, 245),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 60,
                          top: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'history.jpg',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                users,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 60,
                          top: 30,
                          child: Column(
                            children: [
                              Text(
                                index == 0
                                    ? 'Summer'
                                    : index == 1
                                        ? 'Autumn'
                                        : index == 2
                                            ? 'Winter'
                                            : 'Spring',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              if (index == 0)
                                Image.asset(
                                  'history-summer.png',
                                  width: 250,
                                  height: 35,
                                  fit: BoxFit.cover,
                                ),
                              if (index == 1)
                                Image.asset(
                                  'history-autumn.png',
                                  width: 255,
                                  height: 35,
                                  fit: BoxFit.cover,
                                ),
                              if (index == 2)
                                Image.asset(
                                  'history-winter.png',
                                  width: 253,
                                  height: 35,
                                  fit: BoxFit.cover,
                                ),
                              if (index == 3)
                                Image.asset(
                                  'history-spring.png',
                                  width: 253,
                                  height: 35,
                                  fit: BoxFit.cover,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContainer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 155,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset('hist.png'),
          ),
        ),
      ),
    );
  }
}
