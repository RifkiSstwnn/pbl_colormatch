import 'dart:convert'; // Untuk jsonDecode
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:pbl_colormatch/services/history_service.dart'; // Import HistoryService
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class ResultDialog extends StatelessWidget {
  final Map<String, dynamic> latestHistory;
  final HistoryService historyService =
      HistoryService(); // Instance dari HistoryService

  ResultDialog({super.key, required this.latestHistory});

  @override
  Widget build(BuildContext context) {
    // Konversi daftar warna
    List<Color> colorPalette =
        _parseColorPalette(latestHistory['color_palette']);

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
              const Text(
                'Hasil',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.network(
                        latestHistory['foto_output'],
                        height: 170,
                        width: 170,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return const SizedBox(
                            height: 170,
                            width: 170,
                            child: Center(
                                child: Text('Gambar tidak dapat dimuat')),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      latestHistory['name'], // Menampilkan nama
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text('Confidence Level: ${latestHistory['confidence']}'),
              Text('Skin Tone: ${latestHistory['skin_tone']}'),
              const Text('Color Palette:'),
              const SizedBox(height: 10),
              SingleChildScrollView(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: colorPalette.map((color) {
                    return Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.0,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (Route<dynamic> route) => false,
                      );
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

  /// Fungsi untuk mem-parse daftar warna dari data JSON
  List<Color> _parseColorPalette(dynamic colorPalette) {
    try {
      // Jika color_palette adalah string JSON, decode dulu
      if (colorPalette is String) {
        List<dynamic> paletteList = jsonDecode(colorPalette);
        return paletteList.map((hex) {
          return Color(int.parse(hex.toString().replaceFirst('#', '0xFF')));
        }).toList();
      }

      // Jika color_palette sudah berupa List<dynamic>, langsung parse
      if (colorPalette is List<dynamic>) {
        return colorPalette.map((hex) {
          return Color(int.parse(hex.toString().replaceFirst('#', '0xFF')));
        }).toList();
      }
    } catch (e) {
      debugPrint('Error parsing color_palette: $e');
    }

    // Jika gagal mem-parse, return list kosong
    return [];
  }

  void _showEditNameDialog(BuildContext context, Map<String, dynamic> history) {
    final TextEditingController nameController =
        TextEditingController(text: history['name']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Edit Nama',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          content: TextField(
            controller: nameController,
            cursorColor: const Color(0xFF235F60),
            decoration: InputDecoration(
              hintText: "Masukkan nama baru",
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF235F60), width: 2.0),
              ),
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Batal',
                style: TextStyle(
                  color: const Color(0xFF235F60),
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 12,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF235F60),
                minimumSize: const Size(60, 40),
                side: const BorderSide(color: Color(0xFF235F60)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                String newName = nameController.text.trim();
                if (newName.isNotEmpty) {
                  bool success =
                      await historyService.editName(history['id'], newName);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Nama berhasil diperbarui!')),
                    );
                    history['name'] = newName;
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ResultDialog(latestHistory: history);
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gagal memperbarui nama.')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nama tidak boleh kosong.')),
                  );
                }
              },
              style: TextButton.styleFrom(
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
}
