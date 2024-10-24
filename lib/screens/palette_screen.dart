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
            'This skin tone typically has a warm and bright undertone, perfect for showcasing lively colors.',
        'imagePath': 'assets/spring.png', // Add image path
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
            'This skin tone is usually cool and soft, harmonizing with pastel and muted shades.',
        'imagePath': 'assets/summer.png', // Add image path
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
            'This skin tone features rich and warm undertones, ideal for earthy and vibrant colors.',
        'imagePath': 'assets/autumn.png', // Add image path
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
            'This skin tone often has a cool and crisp undertone, complemented by bold and striking colors.',
        'imagePath': 'assets/winter.png', // Add image path
      },
    };

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 90.0, // Maximum height when expanded
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                  left: 30, bottom: 16.0), // Add padding for title
              title: const Text(
                'Color Palette',
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold), // Text size
              ),
              centerTitle: false, // Title not centered
            ),
            pinned: false, // Keeps AppBar visible when scrolling
            elevation: 0, // Remove shadow
          ),
          SliverToBoxAdapter(
            child: _buildImageContainer(), // Place image container here
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final entry = seasonDetails.entries.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      // Navigate to corresponding season's detail page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SkinToneDetailScreen(
                            season: entry.key,
                            description:
                                entry.value['description'], // Pass description
                            skinColors:
                                entry.value['skinColors'] as List<Color>,
                            eyeColors: entry.value['eyeColors'] as List<Color>,
                            eyebrowColors:
                                entry.value['eyebrowColors'] as List<Color>,
                            bestColors:
                                entry.value['bestColors'] as List<Color>,
                            imagePath:
                                entry.value['imagePath'], // Pass image path
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 0,
                      color: const Color.fromARGB(255, 245, 245, 245),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Display season's image
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: DecorationImage(
                                  image: AssetImage(entry.value[
                                      'imagePath']), // Image path from data
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              entry.key, // Display season name
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: seasonDetails.length, // Number of items displayed
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Image container widget
  Widget _buildImageContainer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity, // Full width
        height: 200, // Fixed height for image
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10), // Rounded corners for image
          child: FittedBox(
            fit: BoxFit.cover, // Fit image inside the box
            child: Image.asset('assets/palette.png'), // Image from assets
          ),
        ),
      ),
    );
  }
}
