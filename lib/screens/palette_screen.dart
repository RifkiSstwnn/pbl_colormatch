import 'package:flutter/material.dart';
import 'season_detail_screen.dart'; // Import SkinToneDetailScreen dari file terpisah

class PaletteScreen extends StatelessWidget {
  const PaletteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data untuk musim dan tone warnanya
    final Map<String, Map<String, dynamic>> seasonDetails = {
      'Spring': {
        'skinColors': [const Color(0xFFF8E8D0), const Color(0xFFD2B49C), const Color(0xFF8D5524)],
        'eyeColors': [const Color(0xFF3E2C1C), const Color(0xFF8B4513)],
        'hairColors': [const Color(0xFFCD853F), const Color(0xFF8B4513), const Color(0xFF3E2C1C)],
        'bestColors': [
          const Color(0xFFE6AC27), const Color(0xFF4682B4), const Color(0xFF8A2BE2), const Color(0xFF006400),
          const Color(0xFFD2691E), const Color(0xFF32CD32), const Color(0xFF4682B4), const Color(0xFF6A5ACD),
        ],
        'description': 'This skin tone typically has a warm and bright undertone, perfect for showcasing lively colors.',
      },
      'Summer': {
        'skinColors': [const Color(0xFFF8E8D0), const Color(0xFFD2B49C), const Color(0xFF8D5524)],
        'eyeColors': [const Color(0xFF3E2C1C), const Color(0xFF8B4513)],
        'hairColors': [const Color(0xFFCD853F), const Color(0xFF8B4513), const Color(0xFF3E2C1C)],
        'bestColors': [
          const Color(0xFFE6AC27), const Color(0xFF4682B4), const Color(0xFF8A2BE2), const Color(0xFF006400),
          const Color(0xFFD2691E), const Color(0xFF32CD32), const Color(0xFF4682B4), const Color(0xFF6A5ACD),
        ],
        'description': 'This skin tone is usually cool and soft, harmonizing with pastel and muted shades.',
      },
      'Autumn': {
        'skinColors': [const Color(0xFFF8E8D0), const Color(0xFFD2B49C), const Color(0xFF8D5524)],
        'eyeColors': [const Color(0xFF3E2C1C), const Color(0xFF8B4513)],
        'hairColors': [const Color(0xFFCD853F), const Color(0xFF8B4513), const Color(0xFF3E2C1C)],
        'bestColors': [
          const Color(0xFFE6AC27), const Color(0xFF4682B4), const Color(0xFF8A2BE2), const Color(0xFF006400),
          const Color(0xFFD2691E), const Color(0xFF32CD32), const Color(0xFF4682B4), const Color(0xFF6A5ACD),
        ],
        'description': 'This skin tone features rich and warm undertones, ideal for earthy and vibrant colors.',
      },
      'Winter': {
        'skinColors': [const Color(0xFFF8E8D0), const Color(0xFFD2B49C), const Color(0xFF8D5524)],
        'eyeColors': [const Color(0xFF3E2C1C), const Color(0xFF8B4513)],
        'hairColors': [const Color(0xFFCD853F), const Color(0xFF8B4513), const Color(0xFF3E2C1C)],
        'bestColors': [
          const Color(0xFFE6AC27), const Color(0xFF4682B4), const Color(0xFF8A2BE2), const Color(0xFF006400),
          const Color(0xFFD2691E), const Color(0xFF32CD32), const Color(0xFF4682B4), const Color(0xFF6A5ACD),
        ],
        'description': 'This skin tone often has a cool and crisp undertone, complemented by bold and striking colors.',
      },
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find Your Color',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: seasonDetails.entries.map((entry) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Gambar orang dengan skin tone sesuai musim
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(
                        image: AssetImage('assets/images/${entry.key.toLowerCase()}.jpg'), // Pastikan path gambar ada di assets
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman detail musim yang sesuai
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SkinToneDetailScreen(
                            season: entry.key,
                            description: entry.value['description'], // Kirim deskripsi
                            skinColors: entry.value['skinColors']!,
                            eyeColors: entry.value['eyeColors']!,
                            hairColors: entry.value['hairColors']!,
                            bestColors: entry.value['bestColors']!,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      entry.key, // Menampilkan nama musim
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
