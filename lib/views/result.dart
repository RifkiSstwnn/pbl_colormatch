import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/history_model.dart';
import '../models/history_provider.dart';
import 'home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultDialog extends StatelessWidget {
  final History latestHistory; // Menambahkan parameter

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
                        latestHistory.photoOutput,
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
              SingleChildScrollView(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: latestHistory.colorPalette.map((color) {
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
                print('Nama baru: $newName'); // Debugging
                print('ID History: ${history.id}'); // Debugging

                if (newName.isNotEmpty) {
                  bool success =
                      await Provider.of<HistoryProvider>(context, listen: false)
                          .editName(history.id, newName);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Nama berhasil diperbarui!')));
                    Navigator.of(context).pop(); // Tutup dialog edit
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Gagal memperbarui nama.')));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Nama tidak boleh kosong.')));
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
