import 'dart:io';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final bool isFrontCamera;

  const DisplayPictureScreen({
    super.key,
    required this.imagePath,
    this.isFrontCamera = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Center(
        child: isFrontCamera
            ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.14159), // Flip horizontally
                child: Image.file(File(imagePath)),
              )
            : Image.file(File(imagePath)),
      ),
    );
  }
}
