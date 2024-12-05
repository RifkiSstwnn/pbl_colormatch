import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbl_colormatch/services/upload_service.dart';
import 'package:pbl_colormatch/services/result_service.dart';
import 'package:camera/camera.dart';
import '../models/history_model.dart';
import 'takepicture_screen.dart';
import 'package:pbl_colormatch/views/result.dart';
import 'package:google_fonts/google_fonts.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  final UploadService _uploadService = UploadService();
  final ResultService _resultService = ResultService();

  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _imageList = [
      {
        'image': 'assets/flat-camera1.png',
        'caption':
            'Hindari riasan, perhiasan, kacamata, dan lensa kontak berwarna untuk mendapatkan hasil yang paling akurat.'
      },
      {
        'image': 'assets/flat-camera2.png',
        'caption': 'Cari tempat dengan pencahayaan alami, dan tidak langsung.'
      },
      {
        'image': 'assets/flat-camera3.png',
        'caption': 'Pindai wajahmu menggunakan kamera khusus kami.'
      },
      {
        'image': 'assets/flat-camera4.png',
        'caption': 'Temukan palet warna idealmu.'
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 90.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 30, bottom: 16.0),
              title: Text('Camera',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              centerTitle: false,
            ),
            pinned: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final image = _imageList[index]['image'];
                final caption = _imageList[index]['caption'];

                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        height: 130,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              caption!,
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: _imageList.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera_alt, color: Color(0xFF235F60)),
              label: Text(
                'Kamera',
                style: TextStyle(
                  color: const Color(0xFF235F60),
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 14,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(100, 60),
                side:
                    const BorderSide(color: Color(0xFF235F60)), // Border color
                backgroundColor: Colors.white, // Button background color
              ),
            ),
            OutlinedButton.icon(
              onPressed: _pickImageFromGallery,
              icon: const Icon(Icons.photo_library, color: Color(0xFF235F60)),
              label: Text(
                'Galeri',
                style: TextStyle(
                  color: const Color(0xFF235F60),
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 14,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(100, 60),
                side:
                    const BorderSide(color: Color(0xFF235F60)), // Border color
                backgroundColor: Colors.white, // Button background color
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initializeCameras() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _selectedCameraIndex = 0;
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await _uploadImage(File(pickedFile.path));
    }
  }

  Future<void> _takePicture() async {
    if (_cameras != null && _cameras!.isNotEmpty) {
      final imagePath = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TakePictureScreen(camera: _cameras![_selectedCameraIndex]),
        ),
      );

      if (imagePath != null) {
        await _uploadImage(File(imagePath));
      }
    }
  }

  Future<void> _uploadImage(File file) async {
    print('Uploading image: ${file.path}');

    // Tampilkan dialog loading
    showDialog(
      context: context,
      barrierDismissible:
          false, // Mencegah penutupan dialog dengan mengetuk di luar
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFF235F60)), // Custom color
          ),
        );
      },
    );

    try {
      var result = await _uploadService.uploadImage(file);

      // Tutup dialog loading
      Navigator.of(context).pop();

      if (result != null) {
        // Mendapatkan hasil terbaru menggunakan ResultService
        var latestResult = await _resultService.getResult();
        if (latestResult != null) {
          _showResultDialog(latestResult); // Tampilkan ResultDialog
        } else {
          _showUploadFailedDialog(); // Tampilkan dialog gagal jika tidak ada hasil
        }
      } else {
        print('Failed to upload image');
        _showUploadFailedDialog(); // Tampilkan dialog gagal
      }
    } catch (e) {
      // Tutup dialog loading jika terjadi kesalahan
      Navigator.of(context).pop();
      print('Error during upload: $e');
      _showUploadFailedDialog(); // Tampilkan dialog gagal
    }
  }

  void _showResultDialog(Map<String, dynamic> result) {
    History history = History.fromJson(result); // Pastikan ini benar

    showDialog(
      context: context,
      builder: (context) => ResultDialog(
          latestHistory: history), // Menggunakan konstruktor dengan parameter
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
              Navigator.pop(context); // Tutup dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
