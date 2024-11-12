import 'package:flutter/material.dart';

class DetailHistoryScreen extends StatelessWidget {
  final String skinTone;
  final String colorPalette;
  final String timestamp;
  final String fotoInput;
  final String fotoOutput;

  const DetailHistoryScreen({
    Key? key,
    required this.skinTone,
    required this.colorPalette,
    required this.timestamp,
    required this.fotoInput,
    required this.fotoOutput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Skin Tone: $skinTone', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Color Palette: $colorPalette', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Timestamp: $timestamp', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Image.network(fotoInput, height: 200, fit: BoxFit.cover),
            SizedBox(height: 20),
            Image.network(fotoOutput, height: 200, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
