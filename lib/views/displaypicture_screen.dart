import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pbl_colormatch/services/upload_service.dart';
import 'package:pbl_colormatch/services/result_service.dart';
import 'package:pbl_colormatch/views/result.dart';
import '../models/history_model.dart';
import 'package:pbl_colormatch/views/home_screen.dart';

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
  final ResultService _resultService = ResultService();

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
            // Tombol Batal dengan Icon tanpa Text
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close, color: Colors.red),
              tooltip: 'Batal',
            ),

            // Tombol Analisis dengan Container dan Rounded Corners
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  _uploadImage(File(widget.imagePath));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    'Analisis',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),

            // Tombol Lihat History dengan Container dan Rounded Corners
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    'Lihat History',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadImage(File file) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    var result = await _uploadService.uploadImage(file);

    Navigator.of(context).pop();

    if (result != null) {
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
    History history = History.fromJson(latestHistory);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          latestHistory: history,
          onNameUpdated: (newName) {
            // Handle the name update logic here, if needed
            setState(() {
              // Update logic if you need to reflect the change
              history.name = newName; // Example of updating the name
            });
          },
        );
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
