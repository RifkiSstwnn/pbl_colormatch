import 'dart:convert';
import 'package:flutter/material.dart';

class History {
  final String id; // Pastikan id adalah String
  String name;
  final String photoOutput;
  final String confidence;
  final String skinTone;
  final List<Color> colorPalette;

  History({
    required this.id,
    required this.name,
    required this.photoOutput,
    required this.confidence,
    required this.skinTone,
    required this.colorPalette,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    List<Color> colors = [];

    // Cek tipe color_palette
    if (json['color_palette'] is String) {
      List<dynamic> paletteList = jsonDecode(json['color_palette']);
      colors = paletteList.map((hex) {
        return Color(int.parse(hex.toString().replaceFirst('#', '0xFF')));
      }).toList();
    } else if (json['color_palette'] is List<dynamic>) {
      colors = (json['color_palette'] as List<dynamic>).map((color) {
        return Color(int.parse(color.toString().replaceFirst('#', '0xFF')));
      }).toList();
    }

    // Debugging: Log nilai confidence
    print('Raw confidence value: ${json['confidence']}');

    return History(
      id: json['id'].toString(),
      name: json['name'],
      photoOutput: json['foto_output'],
      confidence: json['confidence'],
      skinTone: json['skin_tone'],
      colorPalette: colors,
    );
  }
}
