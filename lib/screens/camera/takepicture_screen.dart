import 'dart:async';
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
  late FaceDetector _faceDetector;
  bool _isFrontCamera = false;
  bool _isFlashOn = false; // Variabel untuk status flash

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _faceDetector = GoogleMlKit.vision.faceDetector();
  }

  Future<void> _initializeCamera() async {
    try {
      _controller = CameraController(
        widget.camera,
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller.initialize();
      _isFrontCamera = widget.camera.lensDirection == CameraLensDirection.front;

      setState(() {});
    } catch (e) {
      print("Camera initialization error: $e");
    }
  }

  void _toggleCamera() async {
    await _controller.dispose();
    final cameras = await availableCameras();
    final newCamera = _isFrontCamera
        ? cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back)
        : cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front);

    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _controller = CameraController(
        newCamera,
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller.initialize();
    });
  }

  void _toggleFlash() async {
    if (_controller.value.flashMode == FlashMode.torch) {
      await _controller.setFlashMode(FlashMode.off);
      setState(() {
        _isFlashOn = false;
      });
    } else {
      await _controller.setFlashMode(FlashMode.torch);
      setState(() {
        _isFlashOn = true;
      });
    }
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      if (_isFrontCamera) {
        await ScreenBrightness().setScreenBrightness(1.0);
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

        await Future.delayed(Duration(milliseconds: 100));
        final image = await _controller.takePicture();
        Navigator.of(context).pop();
        await ScreenBrightness().resetScreenBrightness();

        final inputImage = InputImage.fromFilePath(image.path);
        final faces = await _faceDetector.processImage(inputImage);

        if (faces.isEmpty) {
          _showFaceNotDetectedDialog();
        } else {
          final face = faces.first;
          if (_isFaceInMaskArea(face.boundingBox)) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                  isFrontCamera: _isFrontCamera,
                ),
              ),
            );
          } else {
            _showFaceNotInMaskDialog();
          }
        }
      } else {
        if (_isFlashOn) {
          await _controller.setFlashMode(FlashMode.torch);
        }
        await Future.delayed(Duration(milliseconds: 100));
        final image = await _controller.takePicture();
        if (_isFlashOn) {
          await _controller.setFlashMode(FlashMode.off);
        }

        final inputImage = InputImage.fromFilePath(image.path);
        final faces = await _faceDetector.processImage(inputImage);

        if (faces.isEmpty) {
          _showFaceNotDetectedDialog();
        } else {
          final face = faces.first;
          if (_isFaceInMaskArea(face.boundingBox)) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                  isFrontCamera: _isFrontCamera,
                ),
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
    const maskArea = Rect.fromLTWH(100, 200, 200, 300);
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
          IconButton(
            icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off),
            onPressed: _toggleFlash,
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
              } else if (snapshot.hasError) {
                return Center(child: Text("Error initializing camera"));
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: FloatingActionButton(
                onPressed: _takePicture,
                child: Icon(Icons.camera),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
