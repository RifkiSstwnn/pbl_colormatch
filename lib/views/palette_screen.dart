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
          const Color(0xFFEED7C3), // Beige (atas tengah)
          const Color(0xFFD2A07E), // Porcelain dengan undertone hangat
          const Color(0xFFAB7B52), // Light golden beige
          const Color(0xFF5C3A28), // Tan hangat
        ],
        'eyeColors': [
          const Color(0xFFB4D7E1), // Aqua pastel
          const Color(0xFF87AEB9), // Biru langit
          const Color(0xFFA3CDB8), // Hijau lembut
        ],
        'eyebrowColors': [
          const Color(0xFFAD8D65), // Blonde hangat
          const Color(0xFF936B49), // Light caramel
          const Color(0xFF7A5133), // Coklat muda hangat
        ],
        'bestColors': [
          const Color(0xFFFAF0B9),
          const Color(0xFF72C161),
          const Color(0xFFF8AF57),
          const Color(0xFFF5A7A6),
          const Color(0xFFAD549E),
          const Color(0xFFF1D0A8),
          const Color(0xFFCDE07B),
          const Color(0xFFF59575),
          const Color(0xFFE7617A),
          const Color(0xFFF6AD56),
          const Color(0xFFFAE46F),
          const Color(0xFF5EA144),
          const Color(0xFFB5DCB7),
          const Color(0xFFF597AA),
          const Color(0xFF3EC5E6),
          const Color(0xFF8E6D44),
          const Color(0xFFA2AA37),
          const Color(0xFF91C86F),
          const Color(0xFFF7D2D2),
          const Color(0xFF3F8CAD),
        ],
        'description':
            'Warna kulit ini biasanya memiliki undertone yang hangat dan cerah, sempurna untuk menampilkan warna-warna yang hidup.',
        'imagePath': 'assets/spring1.png', // Add image path
      },
      'Summer': {
        'skinColors': [
          const Color(0xFFF8E9E6), 
          const Color(0xFFE8D7D3), 
          const Color(0xFFC9B2A6),
          const Color(0xFF846A5B),
        ],
        'eyeColors': [
          const Color(0xFFB8C7D1), // Biru keabu-abuan
          const Color(0xFF98B4CF), // Biru pastel
          const Color(0xFFA4C2D8), // Hijau kebiruan lembut
        ],
        'eyebrowColors': [
          const Color(0xFF9C7D6D), // Ash brown
          const Color(0xFF7B5E52), // Coklat lembut
          const Color(0xFF5A463C), // Coklat netral
        ],
        'bestColors': [
          const Color(0xFFFFFFFF),
          const Color(0xFFB873B0),
          const Color(0xFF6481BE),
          const Color(0xFF83CDBB),
          const Color(0xFFDAA9CE),
          const Color(0xFFB7B7BB),
          const Color(0xFFCFA6CE),
          const Color(0xFF66CAEA),
          const Color(0xFFBB3F6D),
          const Color(0xFF6C68A8),
          const Color(0xFF9E8585),
          const Color(0xFF9E85BD),
          const Color(0xFF6188C5),
          const Color(0xFFE56AA5),
          const Color(0xFF4DC2CE),
          const Color(0xFF000000),
          const Color(0xFFB7B2D8),
          const Color(0xFFA896C8),
          const Color(0xFFC760A1),
          const Color(0xFF80B6AF),
        ],
        'description':
            'Warna kulit ini biasanya sejuk dan lembut, selaras dengan warna pastel dan lembut.',
        'imagePath': 'assets/summer1.png', // Add image path
      },
      'Autumn': {
        'skinColors': [
          const Color(0xFFF1E2D3), // Warm beige
          const Color(0xFFE3C1AD), // Peachy tan
          const Color(0xFFD1947A), // Warm bronze
          const Color(0xFF8A4B33), // Dark Brown (bawah tengah)
        ],
        'eyeColors': [
          const Color(0xFF705639), // Hazel
          const Color(0xFF4F3A26), // Coklat gelap hangat
          const Color(0xFF635134), // Coklat madu
        ],
        'eyebrowColors': [
          const Color(0xFF8B5E3C), // Auburn hangat
          const Color(0xFF6F4F36), // Coklat medium hangat
          const Color(0xFF4B3024), // Coklat tua
        ],
        'bestColors': [
          const Color(0xFFF6ECD3),
          const Color(0xFF279E5D),
          const Color(0xFFEDA852),
          const Color(0xFFBC2D26),
          const Color(0xFF73396B),
          const Color(0xFFDDDF9A),
          const Color(0xFF9E5825),
          const Color(0xFFE08D2D),
          const Color(0xFFB1485D),
          const Color(0xFFDC6F26),
          const Color(0xFFEBD464),
          const Color(0xFF4A7C3A),
          const Color(0xFFB5702E),
          const Color(0xFFF07B90),
          const Color(0xFF238AB1),
          const Color(0xFF66371A),
          const Color(0xFF808334),
          const Color(0xFF6DAB83),
          const Color(0xFFDD9698),
          const Color(0xFF00577C),
        ],
        'description':
            'Warna kulit ini memiliki undertone yang kaya dan hangat, ideal untuk warna bumi dan warna-warna cerah.',
        'imagePath': 'assets/autumn1.png', // Add image path
      },
      'Winter': {
        'skinColors': [
          const Color(0xFFF8E9E6), 
          const Color(0xFFE8D7D3), 
          const Color(0xFFC9B2A6),
          const Color(0xFF846A5B),
        ],
        'eyeColors': [
          const Color(0xFF738FA7), // Abu-abu kebiruan
          const Color(0xFF4C637D), // Biru gelap
          const Color(0xFF344E64), // Hijau zamrud dingin
        ],
        'eyebrowColors': [
          const Color(0xFF3C2E24), // Hitam pekat
          const Color(0xFF5A463C), // Coklat tua
          const Color(0xFF3E2C1C), // Abu-abu gelap
        ],
        'bestColors': [
          const Color(0xFFFFFFFF),
          const Color(0xFFA5479B),
          const Color(0xFF29368C),
          const Color(0xFF90D2C2),
          const Color(0xFFF0D2E5),
          const Color(0xFFA1A0A2),
          const Color(0xFFBA87BC),
          const Color(0xFF3AC1F0),
          const Color(0xFFA41F4D),
          const Color(0xFF5757A5),
          const Color(0xFF655554),
          const Color(0xFFF6F29D),
          const Color(0xFF416FB7),
          const Color(0xFFD42A54),
          const Color(0xFFA41F4D),
          const Color(0xFF000000),
          const Color(0xFFB7B2D8),
          const Color(0xFF675AA7),
          const Color(0xFFC3258A),
          const Color(0xFF49BA79),
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
