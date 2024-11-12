import 'package:flutter/material.dart';
import 'home_screen.dart';

class ResultDialog extends StatelessWidget {
  final Map<String, dynamic> latestHistory;

  const ResultDialog({super.key, required this.latestHistory});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
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
              child: ClipOval(
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
                      child: Center(child: Text('Gambar tidak dapat dimuat')),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text('Skin Tone: ${latestHistory['skin_tone']}'),
            Text('Color Palette: ${latestHistory['color_palette']}'),
            Text('Timestamp: ${latestHistory['timestamp']}'),
            const SizedBox(height: 40),
            // Menyelaraskan tombol
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Menutup dialog
                  },
                  child: const Text('Tutup'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Menutup dialog
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage()), // Arahkan ke halaman beranda
                      (Route<dynamic> route) =>
                          false, // Menghapus semua rute sebelumnya
                    );
                  },
                  child: const Text('Tampilkan History'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}