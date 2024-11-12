import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:pbl_colormatch/services/history_service.dart'; // Import HistoryService

class ResultDialog extends StatelessWidget {
  final Map<String, dynamic> latestHistory;
  final HistoryService historyService =
      HistoryService(); // Instance dari HistoryService

  ResultDialog({super.key, required this.latestHistory});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
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
              Text('Skin Tone: ${latestHistory['skin_tone']}'),
              Text('Color Palette: ${latestHistory['color_palette']}'),
              Text('Nama: ${latestHistory['name']}'),
              Text('Timestamp: ${latestHistory['timestamp']}'),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Menampilkan dialog untuk mengedit nama
                      _showEditNameDialog(context, latestHistory);
                    },
                    child: const Text('Edit Nama'),
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

  void _showEditNameDialog(BuildContext context, Map<String, dynamic> history) {
    final TextEditingController nameController =
        TextEditingController(text: history['name']);

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
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                String newName = nameController.text.trim();
                if (newName.isNotEmpty) {
                  bool success =
                      await historyService.editName(history['id'], newName);
                  if (success) {
                    // Jika berhasil, tampilkan snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Nama berhasil diperbarui!')),
                    );

                    // Memperbarui nama di latestHistory
                    history['name'] = newName;

                    // Memperbarui tampilan dialog
                    Navigator.of(context).pop(); // Menutup dialog edit
                    Navigator.of(context).pop(); // Menutup dialog hasil
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ResultDialog(latestHistory: history);
                      },
                    );
                  } else {
                    // Jika gagal, tampilkan pesan kesalahan
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gagal memperbarui nama.')),
                    );
                  }
                } else {
                  // Jika nama kosong, tampilkan pesan kesalahan
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nama tidak boleh kosong.')),
                  );
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
