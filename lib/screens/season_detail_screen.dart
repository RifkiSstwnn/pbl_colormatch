import 'package:flutter/material.dart';

class SkinToneDetailScreen extends StatelessWidget {
  final String season;
  final String description; // Parameter deskripsi
  final List<Color> skinColors;
  final List<Color> eyeColors;
  final List<Color> hairColors;
  final List<Color> bestColors;

  const SkinToneDetailScreen({super.key, 
    required this.season,
    required this.description, // Tambahkan parameter ini
    required this.skinColors,
    required this.eyeColors,
    required this.hairColors,
    required this.bestColors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skin Tone Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              season,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            const SizedBox(height: 10),
            Text(
              description, // Tampilkan deskripsi di sini
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            // Section for Skin
            _buildSectionTitle('Skin'),
            _buildColorRow(skinColors),

            const SizedBox(height: 20),

            // Section for Eyes
            _buildSectionTitle('Eyes'),
            _buildColorRow(eyeColors),

            const SizedBox(height: 20),

            // Section for Hair
            _buildSectionTitle('Hair'),
            _buildColorRow(hairColors),

            const SizedBox(height: 20),

            // Section for Best Colors (Outfit)
            _buildSectionTitle('Best Color (Outfit)'),
            _buildColorRow(bestColors),

            const SizedBox(height: 20),
            Text(
              'Inilah warna terbaik untuk skin tone $season yang dapat melengkapi kecantikan alami mereka dan menonjolkan fitur-fitur cerah mereka.',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  // Method to build a row of circular color boxes with border
  Widget _buildColorRow(List<Color> colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Mengubah ke start untuk penempatan di kiri
      children: List.generate(colors.length, (index) {
        return Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: colors[index],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2), // Menambahkan border hitam
              ),
            ),
            // Menambahkan jarak antara warna
            if (index < colors.length - 1) const SizedBox(width: 10), // Jarak 10 piksel
          ],
        );
      }),
    );
  }
}
