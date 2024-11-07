import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_history_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 90.0,
            flexibleSpace: const FlexibleSpaceBar(
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
                final seasonData = _getSeasonData(index);
                return _buildHistoryItem(context, seasonData);
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
          child: Image.asset('assets/hist.png', fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(
      BuildContext context, Map<String, dynamic> seasonData) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailHistoryScreen(
              season: seasonData['season'],
              skinColors: seasonData['skinColors'],
              eyeColors: seasonData['eyeColors'],
              eyebrowColors: seasonData['eyebrowColors'],
              bestColors: seasonData['bestColors'],
            ),
          ),
        );
      },
      child: Container(
        height: 140,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 245, 245),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 30,
              top: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/history.jpg',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Alice',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    seasonData['season'],
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Image.asset(
                    'assets/history-${seasonData['season'].toLowerCase()}.png',
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
  }

  Map<String, dynamic> _getSeasonData(int index) {
    final seasons = ['Summer', 'Autumn', 'Winter', 'Spring'];
    final skinColors = [
      const Color(0xFFF8E8D0),
      const Color(0xFFD2B49C),
      const Color(0xFF8D5524)
    ];
    final eyeColors = [const Color(0xFF3E2C1C), const Color(0xFF8B4513)];
    final eyebrowColors = [
      const Color(0xFFCD853F),
      const Color(0xFF8B4513),
      const Color(0xFF3E2C1C)
    ];
    final bestColors = [
      const Color(0xFFE6AC27),
      const Color(0xFF4682B4),
      const Color(0xFF8A2BE2),
      const Color(0xFF006400),
      const Color(0xFFD2691E),
      const Color(0xFF32CD32),
      const Color(0xFF4682B4),
      const Color(0xFF6A5ACD),
    ];

    return {
      'season': seasons[index],
      'skinColors': skinColors,
      'eyeColors': eyeColors,
      'eyebrowColors': eyebrowColors,
      'bestColors': bestColors,
    };
  }

  Future<String?> _getUUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userUUID');
  }
}
