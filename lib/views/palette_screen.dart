import 'package:flutter/material.dart';
import 'season_detail_screen.dart'; // Import SkinToneDetailScreen from a separate file

class PaletteScreen extends StatelessWidget {
  const PaletteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for seasons and their color tones
    final Map<String, Map<String, dynamic>> seasonDetails = {
      'Spring': {
        'skinColors': [
          const Color(0xFFF8E8D0),
          const Color(0xFFD2B49C),
          const Color(0xFF8D5524)
        ],
        'eyeColors': [const Color(0xFF3E2C1C), const Color(0xFF8B4513)],
        'eyebrowColors': [
          const Color(0xFFCD853F),
          const Color(0xFF8B4513),
          const Color(0xFF3E2C1C)
        ],
        'bestColors': [
          const Color(0xFFE6AC27),
          const Color(0xFF4682B4),
          const Color(0xFF8A2BE2),
          const Color(0xFF006400),
          const Color(0xFFD2691E),
          const Color(0xFF32CD32),
          const Color(0xFF4682B4),
          const Color(0xFF6A5ACD),
        ],
        'description':
            'Warna kulit ini biasanya memiliki undertone yang hangat dan cerah, sempurna untuk menampilkan warna-warna yang hidup.',
        'imagePath': 'assets/spring1.png', // Add image path
      },
      'Summer': {
        'skinColors': [
          const Color(0xFFF8E8D0),
          const Color(0xFFD2B49C),
          const Color(0xFF8D5524)
        ],
        'eyeColors': [const Color(0xFF3E2C1C), const Color(0xFF8B4513)],
        'eyebrowColors': [
          const Color(0xFFCD853F),
          const Color(0xFF8B4513),
          const Color(0xFF3E2C1C)
        ],
        'bestColors': [
          const Color(0xFFE6AC27),
          const Color(0xFF4682B4),
          const Color(0xFF8A2BE2),
          const Color(0xFF006400),
          const Color(0xFFD2691E),
          const Color(0xFF32CD32),
          const Color(0xFF4682B4),
          const Color(0xFF6A5ACD),
        ],
        'description':
            'Warna kulit ini biasanya sejuk dan lembut, selaras dengan warna pastel dan lembut.',
        'imagePath': 'assets/summer1.png', // Add image path
      },
      'Autumn': {
        'skinColors': [
          const Color(0xFFF8E8D0),
          const Color(0xFFD2B49C),
          const Color(0xFF8D5524)
        ],
        'eyeColors': [const Color(0xFF3E2C1C), const Color(0xFF8B4513)],
        'eyebrowColors': [
          const Color(0xFFCD853F),
          const Color(0xFF8B4513),
          const Color(0xFF3E2C1C)
        ],
        'bestColors': [
          const Color(0xFFE6AC27),
          const Color(0xFF4682B4),
          const Color(0xFF8A2BE2),
          const Color(0xFF006400),
          const Color(0xFFD2691E),
          const Color(0xFF32CD32),
          const Color(0xFF4682B4),
          const Color(0xFF6A5ACD),
        ],
        'description':
            'Warna kulit ini memiliki undertone yang kaya dan hangat, ideal untuk warna bumi dan warna-warna cerah.',
        'imagePath': 'assets/autumn1.png', // Add image path
      },
      'Winter': {
        'skinColors': [
          const Color(0xFFF8E8D0),
          const Color(0xFFD2B49C),
          const Color(0xFF8D5524)
        ],
        'eyeColors': [const Color(0xFF3E2C1C), const Color(0xFF8B4513)],
        'eyebrowColors': [
          const Color(0xFFCD853F),
          const Color(0xFF8B4513),
          const Color(0xFF3E2C1C)
        ],
        'bestColors': [
          const Color(0xFFE6AC27),
          const Color(0xFF4682B4),
          const Color(0xFF8A2BE2),
          const Color(0xFF006400),
          const Color(0xFFD2691E),
          const Color(0xFF32CD32),
          const Color(0xFF4682B4),
          const Color(0xFF6A5ACD),
        ],
        'description':
            'Warna kulit ini sering memiliki undertone yang sejuk dan segar, yang cocok dengan warna-warna berani dan mencolok.',
        'imagePath': 'assets/winter1.png', // Add image path
      },
    };

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 90.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 30, bottom: 15.0),
              title: Text('Palette',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              centerTitle: false,
            ),
            pinned: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final entry = seasonDetails.entries.elementAt(index);
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to corresponding season's detail page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SkinToneDetailScreen(
                                season: entry.key,
                                description: entry.value['description'],
                                skinColors:
                                    entry.value['skinColors'] as List<Color>,
                                eyeColors:
                                    entry.value['eyeColors'] as List<Color>,
                                eyebrowColors:
                                    entry.value['eyebrowColors'] as List<Color>,
                                bestColors:
                                    entry.value['bestColors'] as List<Color>,
                                imagePath: entry.value['imagePath'],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    image: DecorationImage(
                                      image:
                                          AssetImage(entry.value['imagePath']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        entry.key,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Color(0xffb1e33d),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  );
                },
                childCount: seasonDetails.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
