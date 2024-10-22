import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

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
        title: Text('Camera'),
      ),
      body: Column(
        children: [
          Text(
            'Ambil foto wajah Anda dengan pencahayaan yang baik untuk hasil terbaik.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _takePicture,
                child: Text('Buka Kamera'),
              ),
              ElevatedButton(
                onPressed: _pickImageFromGallery,
                child: Text('Pilih dari Galeri'),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
