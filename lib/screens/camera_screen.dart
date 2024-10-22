import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  CameraScreen({super.key});

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    // Handle file
  }

  Future<void> _takePicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    // Handle file
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Column(
        children: [
          const Text(
            'Ambil foto wajah Anda dengan pencahayaan yang baik untuk hasil terbaik.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _takePicture,
                child: const Text('Buka Kamera'),
              ),
              ElevatedButton(
                onPressed: _pickImageFromGallery,
                child: const Text('Pilih dari Galeri'),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
