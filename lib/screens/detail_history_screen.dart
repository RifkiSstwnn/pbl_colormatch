import 'package:flutter/material.dart';

class DetailHistoryScreen extends StatelessWidget {
  final String season;
  final List<Color> skinColors;
  final List<Color> eyeColors;
  final List<Color> eyebrowColors;
  final List<Color> bestColors;

  DetailHistoryScreen({
    required this.season,
    required this.skinColors,
    required this.eyeColors,
    required this.eyebrowColors,
    required this.bestColors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$season Color Result')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20), // Spacer from the top
            Image.asset(
              'assets/history-wraped.png', // Image displayed
              width: 150,
              height: 230,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20), // Spacer between image and text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '$season!',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center, // Center the title
              ),
            ),
            SizedBox(height: 20), // Spacer between title and color sections
            _buildColorSection('Skin Colors', skinColors),
            _buildColorSection('Eye Colors', eyeColors),
            _buildColorSection('Eyebrow Colors', eyebrowColors),
            _buildColorSection('Best Colors', bestColors),
          ],
        ),
      ),
    );
  }

  // Method to build a section of colors with title and color row
  Widget _buildColorSection(String title, List<Color> colors) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to the start
        children: [
          Container(
            margin: EdgeInsets.only(left: 30), // Add left margin of 10
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left, // Ensure title is left-aligned
            ),
          ),
          SizedBox(height: 10), // Spacer between title and colors
          // Wrap the color row in a Container to add left margin
          Container(
            margin: EdgeInsets.only(left: 30), // Add left margin of 10
            child: Align(
              alignment:
                  Alignment.centerLeft, // Align the color row to the left
              child: _buildColorRow(colors), // Use row for color display
            ),
          ),
        ],
      ),
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
            border:
                Border.all(color: Colors.black, width: 2), // Add black border
          ),
        );
      }),
    );
  }
}
