import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/history_model.dart';
import '../services/history_service.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'home_screen.dart';

class ResultDialog extends StatelessWidget {
  final History latestHistory; // Menambahkan parameter
  final HistoryService _historyService = HistoryService();
  final ScreenshotController _screenshotController = ScreenshotController();

  ResultDialog({Key? key, required this.latestHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screenshot hanya bagian ini
              Screenshot(
                controller: _screenshotController,
                child: Container(
                  color: Colors.white, // Background putih untuk screenshot
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hasil',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.network(
                                latestHistory.photoOutput,
                                height: 170,
                                width: 170,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  return const SizedBox(
                                    height: 170,
                                    width: 170,
                                    child: Center(
                                        child:
                                            Text('Gambar tidak dapat dimuat')),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              latestHistory.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text('Confidence Level: ${latestHistory.confidence}'),
                      Text('Skin Tone: ${latestHistory.skinTone}'),
                      const Text('Color Palette:'),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: latestHistory.colorPalette.map((color) {
                          return Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black12, width: 1.0),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              // Tombol Aksi (di luar Screenshot)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Download hanya icon
                  IconButton(
                    onPressed: () async {
                      await _downloadResult(context);
                    },
                    icon: const Icon(Icons.download, color: Color(0xFF235F60)),
                    tooltip: 'Download',
                  ),
                  // Tombol Edit Nama
                  OutlinedButton.icon(
                    onPressed: () {
                      _showEditNameDialog(context, latestHistory);
                    },
                    icon: const Icon(Icons.edit, color: Color(0xFF235F60)),
                    label: Text(
                      'Edit Nama',
                      style: TextStyle(
                        color: const Color(0xFF235F60),
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 12,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(60, 40),
                      side: const BorderSide(color: Color(0xFF235F60)),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  // Tombol Tutup
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomePage()),
                      //   (Route<dynamic> route) => false,
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF235F60),
                    ),
                    child: const Text('Tutup'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dialog Edit Nama
  void _showEditNameDialog(BuildContext context, History history) {
    final TextEditingController nameController =
        TextEditingController(text: history.name);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Nama'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Masukkan nama baru"),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String newName = nameController.text.trim();

                if (newName.isNotEmpty) {
                  bool success =
                      await _historyService.editName(history.id, newName);
                  Navigator.of(context).pop();

                  if (success) {
                    history.name = newName;
                    _showSuccessDialogEditName(
                        context, 'Nama berhasil diperbarui!');
                    // Navigator.of(context).pop();
                  } else {
                    _showErrorDialog(context, 'Gagal memperbarui nama.');
                  }
                } else {
                  _showErrorDialog(context, 'Nama tidak boleh kosong.');
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi Download Result
  Future<void> _downloadResult(BuildContext context) async {
    try {
      // Mengambil screenshot dari controller
      final image = await _screenshotController.capture();
      if (image == null) return;

      // Mendapatkan direktori "Download" di perangkat Android
      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Menentukan nama file berdasarkan timestamp
      final filePath =
          '${directory.path}/result_${DateTime.now().millisecondsSinceEpoch}.png';

      // Menyimpan file ke folder Download
      final file = File(filePath);
      await file.writeAsBytes(image);

      // Menampilkan pesan sukses
      _showSuccessDialog(context, 'Hasil berhasil disimpan di folder Download');
    } catch (e) {
      print("Error saat menyimpan hasil: $e");
      // Menampilkan pesan error
      _showErrorDialog(context, 'Gagal menyimpan hasil');
    }
  }

  // Dialog untuk Sukses
  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Berhasil'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialogEditName(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Berhasil'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Dialog untuk Gagal
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Gagal'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Coba Lagi'),
            ),
          ],
        );
      },
    );
  }
}
