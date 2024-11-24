import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:pbl_colormatch/services/history_service.dart'; // Import HistoryService
import 'package:google_fonts/google_fonts.dart'; // Ensure you import Google Fonts

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
      backgroundColor: Colors.white, // Set the background color to white
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
              Text('Timestamp: ${latestHistory['timestamp']}'),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Modified Edit Name button with smaller size
                  OutlinedButton.icon(
                    onPressed: () {
                      // Menampilkan dialog untuk mengedit nama
                      _showEditNameDialog(context, latestHistory);
                    },
                    icon: const Icon(Icons.edit, color: Color(0xFF235F60)),
                    label: Text(
                      'Edit Nama',
                      style: TextStyle(
                        color: const Color(0xFF235F60),
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 12, // Reduced font size
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(60, 40), // Reduced minimum size
                      side: const BorderSide(
                          color: Color(0xFF235F60)), // Border color
                      backgroundColor: Colors.white, // Button background color
                    ),
                  ),
                  // Modified button with green background and white text
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
          backgroundColor: Colors.white, // Set the background color to white
          content: TextField(
            controller: nameController,
            cursorColor: const Color(0xFF235F60), // Set cursor color to green
            decoration: InputDecoration(
              hintText: "Masukkan nama baru",
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF235F60), width: 2.0),
              ),
            ),
          ),
          actions: [
            // Modified Batal button to meet the specified requirements
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: Text(
                'Batal',
                style: TextStyle(
                  color: const Color(0xFF235F60), // Text color
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 12, // Reduced font size
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white, // Background color
                foregroundColor: const Color(0xFF235F60), // Text color
                minimumSize: const Size(60, 40), // Minimum size
                side:
                    const BorderSide(color: Color(0xFF235F60)), // Border color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Radius 50
                ),
              ),
            ),
            // Modified Simpan button with green background and white text
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
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Text color
                backgroundColor: const Color(0xFF235F60), // Background color
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
