import 'package:flutter/material.dart';

class SkinToneDetailScreen extends StatelessWidget {
  final String season;
  final String description; // Parameter deskripsi
  final List<Color> skinColors;
  final List<Color> eyeColors;
  final List<Color> eyebrowColors;
  final List<Color> bestColors;
  final String imagePath; // Add image path parameter

  const SkinToneDetailScreen({
    super.key,
    required this.season,
    required this.description, // Tambahkan parameter ini
    required this.skinColors,
    required this.eyeColors,
    required this.eyebrowColors,
    required this.bestColors,
    required this.imagePath, // Add image path parameter
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skin Tone Details'),
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Display the image with rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // Adjust the image to cover the space
              ),
            ),
            const SizedBox(height: 10), // Space between image and description

            Text(
              description, // Tampilkan deskripsi di sini
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Container with rounded corners for color sections
            Container(
              // decoration: BoxDecoration(
              //   color: Colors.grey[200], // Background color
              //   borderRadius: BorderRadius.circular(10), // Rounded corners
              // ),
              padding:
                  const EdgeInsets.all(20.0), // Padding inside the container
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section for Skin
                  _buildSectionTitle('Skin'),
                  _buildColorRow(skinColors),

                  const SizedBox(height: 20),

                  // Section for Eyes
                  _buildSectionTitle('Eyes'),
                  _buildColorRow(eyeColors),

                  const SizedBox(height: 20),

                  // Section for Eyebrow
                  _buildSectionTitle('Eyebrow'),
                  _buildColorRow(eyebrowColors),

                  const SizedBox(height: 20),

                  // Section for Best Colors (Outfit)
                  _buildSectionTitle('Best Color (Outfit)'),
                  _buildColorRow(bestColors),
                ],
              ),
            ),

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
    return Wrap(
      spacing: 10, // Space between colors
      runSpacing: 10, // Space between rows
      children: List.generate(colors.length, (index) {
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: colors[index],
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.black, width: 2), // Menambahkan border hitam
          ),
        );
      }),
    );
  }
}
