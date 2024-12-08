import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/history_model.dart';
import '../services/history_service.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';

class ResultDialog extends StatefulWidget {
  final History latestHistory;
  final Function(String) onNameUpdated; // Callback for name updates

  ResultDialog({
    Key? key,
    required this.latestHistory,
    required this.onNameUpdated, // Accept callback
  }) : super(key: key);

  @override
  _ResultDialogState createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  final HistoryService _historyService = HistoryService();
  final ScreenshotController _screenshotController = ScreenshotController();

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
              Screenshot(
                controller: _screenshotController,
                child: Container(
                  color: Colors.white,
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
                                widget.latestHistory.photoOutput,
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
                              widget.latestHistory.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                          'Confidence Level: ${widget.latestHistory.confidence}'),
                      Text('Skin Tone: ${widget.latestHistory.skinTone}'),
                      const Text('Color Palette:'),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children:
                            widget.latestHistory.colorPalette.map((color) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      await _downloadResult(context);
                    },
                    icon: const Icon(Icons.download, color: Color(0xFF235F60)),
                    tooltip: 'Download',
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      _showEditNameDialog(context);
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
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF235F60),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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

  void _showEditNameDialog(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: widget.latestHistory.name);

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
                  bool success = await _historyService.editName(
                      widget.latestHistory.id, newName);
                  Navigator.of(context).pop();

                  if (success) {
                    widget.onNameUpdated(
                        newName); // Call the callback to update the name
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Name updated successfully!')));
                  } else {
                    _showErrorDialog(context, 'Gagal memperbarui nama.');
                  }
                } else {
                  _showErrorDialog(context, 'Nama tidak boleh kosong.');
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF235F60),
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _downloadResult(BuildContext context) async {
    try {
      final image = await _screenshotController.capture();
      if (image == null) return;

      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final filePath =
          '${directory.path}/result_${DateTime.now().millisecondsSinceEpoch}.png';

      final file = File(filePath);
      await file.writeAsBytes(image);

      _showSuccessDialog(context, 'Hasil berhasil disimpan di folder Download');
    } catch (e) {
      print("Error saat menyimpan hasil: $e");
      _showErrorDialog(context, 'Gagal menyimpan hasil');
    }
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Berhasil'),
          content: Text(message),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF235F60),
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Gagal'),
          content: Text(message),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF235F60),
              ),
              child: const Text('Coba Lagi'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialogEditName(
      BuildContext context, String message, VoidCallback onReload) {
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
                onReload(); // Panggil callback untuk reload halaman
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF235F60),
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
