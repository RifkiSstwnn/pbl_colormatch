import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'displaypicture_screen.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  TakePictureScreen({required this.camera});

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0;
  late FaceDetector _faceDetector;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
    _faceDetector = GoogleMlKit.vision.faceDetector();
  }

  Future<void> _initializeCameras() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _selectedCameraIndex = _cameras!.indexOf(widget.camera);
      _initializeCamera(_cameras![_selectedCameraIndex]);
    }
  }

  void _initializeCamera(CameraDescription cameraDescription) {
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  void _toggleCamera() {
    if (_cameras != null && _cameras!.length > 1) {
      if (_controller.description.lensDirection == CameraLensDirection.front) {
        _selectedCameraIndex = _cameras!.indexWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back,
        );
      } else {
        _selectedCameraIndex = _cameras!.indexWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
        );
      }
      _controller.dispose().then((_) {
        _initializeCamera(_cameras![_selectedCameraIndex]);
      });
    }
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      // Check if it's the front camera
      if (_controller.description.lensDirection == CameraLensDirection.front) {
        // Set max brightness for front camera flash effect
        await ScreenBrightness().setScreenBrightness(1.0);

        // Display overlay for a flash effect
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Container(
            color: Colors.white,
            child: Center(
              child: Icon(Icons.flash_on, color: Colors.yellow, size: 50),
            ),
          ),
        );

        // Wait for a brief moment with the overlay flash active
        await Future.delayed(Duration(milliseconds: 100));

        // Capture image while flash overlay is still active
        final image = await _controller.takePicture();

        // Close the overlay flash effect
        Navigator.of(context).pop();

        // Reset brightness
        await ScreenBrightness().resetScreenBrightness();

        // Detect faces in the image
        final inputImage = InputImage.fromFilePath(image.path);
        final faces = await _faceDetector.processImage(inputImage);

        // Check if a face is detected
        if (faces.isEmpty) {
          _showFaceNotDetectedDialog();
        } else {
          // Check if face is within the mask area (for simplicity, we'll check the face position)
          final face = faces.first;
          if (_isFaceInMaskArea(face.boundingBox)) {
            // Proceed to display picture screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DisplayPictureScreen(imagePath: image.path),
              ),
            );
          } else {
            _showFaceNotInMaskDialog();
          }
        }
      } else {
        // Use back camera with flash mode always for the photo
        await _controller.setFlashMode(FlashMode.torch);

        // Add a slight delay to ensure the flash triggers before capturing the picture
        await Future.delayed(Duration(milliseconds: 100));

        final image = await _controller.takePicture();

        // Turn off the flash after taking the picture
        await _controller.setFlashMode(FlashMode.off);

        // Detect faces in the image
        final inputImage = InputImage.fromFilePath(image.path);
        final faces = await _faceDetector.processImage(inputImage);

        // Check if a face is detected
        if (faces.isEmpty) {
          _showFaceNotDetectedDialog();
        } else {
          // Check if face is within the mask area (for simplicity, we'll check the face position)
          final face = faces.first;
          if (_isFaceInMaskArea(face.boundingBox)) {
            // Proceed to display picture screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DisplayPictureScreen(imagePath: image.path),
              ),
            );
          } else {
            _showFaceNotInMaskDialog();
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  bool _isFaceInMaskArea(Rect faceBoundingBox) {
    // Define mask area (a simple example, you can modify this to match your mask area)
    const maskArea = Rect.fromLTWH(100, 200, 200, 300); // Example mask area

    return maskArea.overlaps(faceBoundingBox);
  }

  void _showFaceNotDetectedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tidak ada wajah terdeteksi'),
        content: Text('Silahkan ambil foto lagi dengan wajah terlihat jelas.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showFaceNotInMaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Wajah tidak di area mask'),
        content: Text('Pastikan wajah Anda berada di area mask.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ambil Gambar'),
        actions: [
          IconButton(
            icon: Icon(Icons.flip_camera_android),
            onPressed: _toggleCamera,
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned.fill(
            child: ClipPath(
              clipper: OvalClipper(),
              child: Container(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: Icon(Icons.camera),
      ),
    );
  }
}

// Custom Clipper for the Oval Cutout
class OvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 250,
        height: 350,
      ))
      ..fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(OvalClipper oldClipper) => false;
}
