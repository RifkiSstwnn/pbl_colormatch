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
          const Color(0xFFFFE8D1), // Porcelain dengan undertone hangat
          const Color(0xFFF5D3AA), // Light golden beige
          const Color(0xFFE3AC7F), // Tan hangat
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
          const Color(0xFFFFFFFF),
          const Color(0xFFE6E4E3),
          const Color(0xFFD5D8DC),
          const Color(0xFFC2C4C7),
          const Color(0xFFCBC6C6),
          const Color(0xFFCEC2BC),
          const Color(0xFFCAC0B5),
          const Color(0xFFC2BFD3),
          const Color(0xFFB7C0D3),
          const Color(0xFF9FA7B7),
          const Color(0xFF848EA3),
          const Color(0xFF57646A),
          const Color(0xFF39454F),
          const Color(0xFF23356D),
          const Color(0xFF78BBE3),
          const Color(0xFF5798C7),
          const Color(0xFF578BB3),
          const Color(0xFF3871A8),
          const Color(0xFF3366A2),
          const Color(0xFF365782),
          const Color(0xFF4A6591),
          const Color(0xFF7673AF),
          const Color(0xFF4884B0),
          const Color(0xFF23AEC6),
          const Color(0xFF12A0B3),
          const Color(0xFF398CA2),
          const Color(0xFF348FA4),
          const Color(0xFF7FC4B6),
          const Color(0xFF4E8787),
          const Color(0xFF177972),
          const Color(0xFF1D716D),
          const Color(0xFFD8DF99),
          const Color(0xFFE3E0B0),
          const Color(0xFFDDBEC0),
          const Color(0xFFE1AFCE),
          const Color(0xFFE79CC1),
          const Color(0xFFCD81AF),
          const Color(0xFFCB5890),
          const Color(0xFFDE5F89),
          const Color(0xFFE85B85),
          const Color(0xFFCE4A69),
          const Color(0xFF893751),
          const Color(0xFF6D4B5C),
        ],
        'description':
            'Warna kulit ini biasanya memiliki undertone yang hangat dan cerah, sempurna untuk menampilkan warna-warna yang hidup.',
        'imagePath': 'assets/spring1.png', // Add image path
      },
      'Summer': {
        'skinColors': [
          const Color(0xFFF6E6DA), // Kulit porselen pucat
          const Color(0xFFE8D4C8), // Kulit ivory dengan undertone pink
          const Color(0xFFD1B5A0), // Kulit netral terang
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
          const Color(0xFFFDFDFB),
          const Color(0xFFF6F1D5),
          const Color(0xFFE8CAA4),
          const Color(0xFFCDB79C),
          const Color(0xFFC8B89D),
          const Color(0xFFC4B187),
          const Color(0xFFC3A170),
          const Color(0xFFE3A671),
          const Color(0xFFC7835D),
          const Color(0xFFAF7751),
          const Color(0xFF946B4C),
          const Color(0xFF7B553C),
          const Color(0xFF586859),
          const Color(0xFF179DDB),
          const Color(0xFF1F62BE),
          const Color(0xFF142898),
          const Color(0xFF7C57B8),
          const Color(0xFF6D4C99),
          const Color(0xFF71417F),
          const Color(0xFFB5BE47),
          const Color(0xFF8DA63C),
          const Color(0xFF679026),
          const Color(0xFF57B621),
          const Color(0xFF37C83B),
          const Color(0xFF25B15D),
          const Color(0xFF32AF91),
          const Color(0xFF0FA894),
          const Color(0xFF0F918B),
          const Color(0xFF12996B),
          const Color(0xFF1A794A),
          const Color(0xFF648E3F),
          const Color(0xFFFDC833),
          const Color(0xFFF1B11F),
          const Color(0xFFF8A36C),
          const Color(0xFFFE7F75),
          const Color(0xFFFE7362),
          const Color(0xFFFE7771),
          const Color(0xFFF57594),
          const Color(0xFFE44770),
          const Color(0xFFE12868),
          const Color(0xFFE8435A),
          const Color(0xFFDC3540),
          const Color(0xFFE67584),
        ],
        'description':
            'Warna kulit ini biasanya sejuk dan lembut, selaras dengan warna pastel dan lembut.',
        'imagePath': 'assets/summer1.png', // Add image path
      },
      'Autumn': {
        'skinColors': [
          const Color(0xFFF3D8C4), // Warm beige
          const Color(0xFFD2A57D), // Peachy tan
          const Color(0xFFB08065), // Warm bronze
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
          const Color(0xFFFFFEFE),
          const Color(0xFFE7E8EA),
          const Color(0xFFDCDEDC),
          const Color(0xFFDCDBD8),
          const Color(0xFFB4B3B2),
          const Color(0xFF8C8D8C),
          const Color(0xFF646768),
          const Color(0xFF353947),
          const Color(0xFF302847),
          const Color(0xFF29192F),
          const Color(0xFF060633),
          const Color(0xFF0C1179),
          const Color(0xFF558ECA),
          const Color(0xFF37A1FF),
          const Color(0xFF3967DC),
          const Color(0xFF2352BA),
          const Color(0xFF1347B0),
          const Color(0xFF08259A),
          const Color(0xFFA4AADA),
          const Color(0xFFA78CC2),
          const Color(0xFF6C499D),
          const Color(0xFF552B86),
          const Color(0xFF9781A4),
          const Color(0xFF78D3A1),
          const Color(0xFF1A9C85),
          const Color(0xFF088274),
          const Color(0xFF049C72),
          const Color(0xFF118052),
          const Color(0xFF1F443A),
          const Color(0xFFBABB53),
          const Color(0xFFF6E432),
          const Color(0xFFFBE063),
          const Color(0xFFFBEE83),
          const Color(0xFFFD77BC),
          const Color(0xFFD8368A),
          const Color(0xFF9A2E66),
          const Color(0xFFE6407E),
          const Color(0xFFE51160),
          const Color(0xFFD4195D),
          const Color(0xFFAA2141),
          const Color(0xFF99122D),
          const Color(0xFF962C48),
          const Color(0xFFF9F4F6),
          const Color(0xFFF3F3F5),
          const Color(0xFFECEBEF),
          const Color(0xFFFFFFFF),
        ],
        'description':
            'Warna kulit ini memiliki undertone yang kaya dan hangat, ideal untuk warna bumi dan warna-warna cerah.',
        'imagePath': 'assets/autumn1.png', // Add image path
      },
      'Winter': {
        'skinColors': [
          const Color(0xFFF3E9E2), // Porselen terang dengan undertone biru
          const Color(0xFFD6B3A9), // Warna netral cool
          const Color(0xFF8B5C4D), // Coklat gelap dengan undertone dingin
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
          const Color(0xFFFEFEFE),
          const Color(0xFFE7E8EA),
          const Color(0xFFDCDCDC),
          const Color(0xFFDCD9D8),
          const Color(0xFFB4B3B2),
          const Color(0xFF8C8D8C),
          const Color(0xFF646768),
          const Color(0xFF353947),
          const Color(0xFF302847),
          const Color(0xFF29192F),
          const Color(0xFF060633),
          const Color(0xFF0C1179),
          const Color(0xFF558ECA),
          const Color(0xFF37A1FF),
          const Color(0xFF3967DC),
          const Color(0xFF2352BA),
          const Color(0xFF1347B0),
          const Color(0xFF08259A),
          const Color(0xFFA4AADA),
          const Color(0xFFA78CC2),
          const Color(0xFF6C499D),
          const Color(0xFF552B86),
          const Color(0xFF9781A4),
          const Color(0xFF78D3A1),
          const Color(0xFF1A9C85),
          const Color(0xFF088274),
          const Color(0xFF049C72),
          const Color(0xFF118052),
          const Color(0xFF1F443A),
          const Color(0xFFBABB53),
          const Color(0xFFF6E432),
          const Color(0xFFFBE063),
          const Color(0xFFFBBEE3),
          const Color(0xFFFD77BC),
          const Color(0xFFD8368A),
          const Color(0xFF9A2E66),
          const Color(0xFFE6407E),
          const Color(0xFFE51160),
          const Color(0xFFD4195D),
          const Color(0xFFAA2141),
          const Color(0xFF99122D),
          const Color(0xFF962C48),
          const Color(0xFFF9F4F6),
          const Color(0xFFF3F3F5),
          const Color(0xFFECEBEF),
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
