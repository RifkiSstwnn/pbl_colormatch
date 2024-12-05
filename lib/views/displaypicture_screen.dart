import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pbl_colormatch/services/upload_service.dart';
import 'package:pbl_colormatch/services/result_service.dart';
import 'package:pbl_colormatch/views/result.dart';

import '../models/history_model.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final bool isFrontCamera;

  const DisplayPictureScreen({
    super.key,
    required this.imagePath,
    this.isFrontCamera = false,
  });

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  final UploadService _uploadService = UploadService();
  final ResultService _resultService =
      ResultService(); // Instance dari ResultService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Preview')),
      body: Center(
        child: widget.isFrontCamera
            ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.14159),
                child: Image.file(File(widget.imagePath)),
              )
            : Image.file(File(widget.imagePath)),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () {
                _uploadImage(File(widget.imagePath));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadImage(File file) async {
    // Tampilkan dialog loading
    showDialog(
      context: context,
      barrierDismissible:
          false, // Mencegah penutupan dialog dengan mengetuk di luar
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(), // Menampilkan indikator loading
        );
      },
    );

    var result = await _uploadService.uploadImage(file);

    // Tutup dialog loading
    Navigator.of(context).pop();

    if (result != null) {
      // Setelah upload berhasil, ambil data terbaru dari API
      _fetchLatestHistory();
    } else {
      _showUploadFailedDialog();
    }
  }

  Future<void> _fetchLatestHistory() async {
    final latestHistory = await _resultService.getResult();

    if (latestHistory != null) {
      _navigateToResultScreen(latestHistory);
    } else {
      _showFetchFailedDialog();
    }
  }

  void _navigateToResultScreen(Map<String, dynamic> latestHistory) {
  // Mengonversi Map<String, dynamic> ke objek History
  History history = History.fromJson(latestHistory);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ResultDialog(latestHistory: history);
    },
  );
}

  void _showUploadFailedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upload Gagal'),
        content:
            const Text('Gambar tidak valid. Silakan ambil gambar kembali.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showFetchFailedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Fetch Gagal'),
        content: const Text('Gagal mengambil data terbaru.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
