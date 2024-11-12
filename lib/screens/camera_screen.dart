// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:camera/camera.dart';
// import 'camera/takepicture_screen.dart';
// import 'package:pbl_colormatch/services/upload_service.dart';
// import 'dart:io';

// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   final ImagePicker _picker = ImagePicker();
//   final UploadService _uploadService = UploadService(); // Inisialisasi UploadService
//   String? _skinTone;
//   String? _colorPalette;

//   Future<void> _pickImageFromGallery() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       await _uploadImage(File(pickedFile.path));
//     }
//   }

//   Future<void> _takePicture() async {
//     try {
//       // Get the list of available cameras
//       final cameras = await availableCameras();
//       final firstCamera = cameras.first;

//       // Navigate to TakePictureScreen with the selected camera
//       final result = await Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => TakePictureScreen(camera: firstCamera),
//         ),
//       );

//       // Jika ada gambar yang diambil, unggah gambar tersebut
//       if (result != null && result is File) {
//         await _uploadImage(result);
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> _uploadImage(File file) async {
//     print('Uploading image: ${file.path}');
//     var result = await _uploadService.uploadImage(file); // Menggunakan UploadService

//     if (result != null) {
//       setState(() {
//         _skinTone = result['skin_tone'];
//         _colorPalette = result['color_palette'];
//       });
//       print('Skin Tone: $_skinTone');
//       print('Color Palette: $_colorPalette');
//     } else {
//       print('Failed to upload image');
//     }
//   }

//   final List<Map<String, String>> _imageList = [
//     {
//       'image': 'assets/flat-penjelasan1.png',
//       'caption':
//           'Ambil foto wajah Anda dengan pencahayaan yang baik untuk hasil terbaik.'
//     },
//     {
//       'image': 'assets/flat-penjelasan2.png',
//       'caption': 'Pastikan wajah Anda terlihat jelas.'
//     },
//     {
//       'image': 'assets/flat-penjelasan3.png',
//       'caption': 'Gunakan latar belakang yang sederhana.'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 90.0, // Tinggi maksimum saat diperluas
//             flexibleSpace: FlexibleSpaceBar(
//               titlePadding: EdgeInsets.only(left: 30, bottom: 16.0),
//               title: Text('Pindai',
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold)), // Ukuran teks
//               centerTitle: false,
//             ),
//             pinned: false, // Menjaga AppBar tetap terlihat saat digulir
//             elevation: 0, // Hilangkan bayangan
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 final image = _imageList[index]['image'];
//                 final caption = _imageList[index]['caption'];

//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start, // Atur alignment teks
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width *
//                             0.35, // Sesuaikan lebar gambar berdasarkan lebar layar
//                         height: 150, // Kurangi tinggi gambar
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.circular(10), // Sudut membulat
//                           image: DecorationImage(
//                             image: AssetImage(
//                                 image!), // Pastikan gambar ada di assets
//                             fit: BoxFit
//                                 .cover, // Mengatur cara gambar ditampilkan
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 16), // Jarak antara gambar dan teks
//                       Expanded(
//                         // Gunakan Expanded untuk teks agar tidak overflow
//                         child: Text(
//                           caption!, // Teks keterangan
//                           textAlign: TextAlign.left,
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               childCount: _imageList.length, // Jumlah item di ListView
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             ElevatedButton.icon(
//               onPressed: _takePicture,
//               icon: Icon(Icons.camera_alt), // Ikon kamera
//               label: Text('Buka Kamera'),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(100, 60), // Lebar dan tinggi tombol
//                 textStyle: TextStyle(fontSize: 16), // Ukuran teks tombol
//               ),
//             ),
//             ElevatedButton.icon(
//               onPressed: _pickImageFromGallery,
//               icon: Icon(Icons.photo_library), // Ikon galeri
//               label: Text('Pilih dari Galeri'),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(100, 60), // Lebar dan tinggi tombol
//                 textStyle: TextStyle(fontSize: 16), // Ukuran teks tombol
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbl_colormatch/services/upload_service.dart';
import 'package:pbl_colormatch/services/result_service.dart';
import 'package:camera/camera.dart';
import 'camera/takepicture_screen.dart';
import 'package:pbl_colormatch/screens/result.dart';

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
        return Center(
          child: CircularProgressIndicator(), // Menampilkan indikator loading
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
    showDialog(
      context: context,
      builder: (context) => ResultDialog(latestHistory: result),
    );
  }

  void _showUploadFailedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upload Gagal'),
        content: Text('Gambar tidak valid. Silakan ambil gambar kembali.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  final List<Map<String, String>> _imageList = [
    {
      'image': 'assets/flat-penjelasan1.png',
      'caption':
          'Ambil foto wajah Anda dengan pencahayaan yang baik untuk hasil terbaik.'
    },
    {
      'image': 'assets/flat-penjelasan2.png',
      'caption': 'Pastikan wajah Anda terlihat jelas.'
    },
    {
      'image': 'assets/flat-penjelasan3.png',
      'caption': 'Gunakan latar belakang yang sederhana.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 90.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 30, bottom: 16.0),
              title: Text('Pindai',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              centerTitle: false,
            ),
            pinned: false,
            elevation: 0,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final image = _imageList[index]['image'];
                final caption = _imageList[index]['caption'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          caption!,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16),
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
            ElevatedButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.camera_alt),
              label: Text('Buka Kamera'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 60),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _pickImageFromGallery,
              icon: Icon(Icons.photo_library),
              label: Text('Pilih dari Galeri'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 60),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

