import 'package:flutter/material.dart';
import 'package:pbl_colormatch/services/history_service.dart';
import 'result.dart'; // Mengimpor ResultDialog

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<dynamic>?> _historyFuture;
  final HistoryService _historyService = HistoryService();

  @override
  void initState() {
    super.initState();
    _historyFuture =
        _historyService.getHistory(); // Ambil seluruh history dari service
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>?>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No history found.'));
          }

          final historyList = snapshot.data!; // Ambil seluruh data history

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight:
                    80.0, // Tinggi yang lebih besar untuk memberikan ruang
                backgroundColor: const Color.fromARGB(
                    255, 255, 255, 255), // Ganti dengan warna yang diinginkan
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Scan History',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  titlePadding: const EdgeInsets.only(
                      bottom: 10.0, left: 20), // Padding bawah untuk judul
                ),
                pinned: true, // Menjaga AppBar tetap terlihat saat scroll
                elevation: 0,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _buildHistoryItem(context, historyList[index]);
                  },
                  childCount: historyList.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHistoryItem(
      BuildContext context, Map<String, dynamic> historyData) {
    int id = historyData['id']; // Ambil ID dari historyData

    return InkWell(
      onTap: () {
        // Menampilkan ResultDialog saat item di klik
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ResultDialog(latestHistory: historyData);
          },
        );
      },
      child: Container(
        height: 140,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 244, 244),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 30,
              top: 18,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kolom untuk gambar dan nama di bawahnya
                  Column(
                    children: [
                      // Gambar
                      ClipOval(
                        child: Image.network(
                          historyData['foto_output'] ??
                              '', // URL foto output dari API
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const SizedBox(
                              height: 80,
                              width: 80,
                              child: Center(
                                  child: Text('Gambar tidak dapat dimuat')),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 5), // Jarak antara gambar dan nama
                      // Nama di bawah gambar
                      Text(
                        historyData['name'] ??
                            'Unknown', // Tampilkan nama atau nilai default
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                      width: 55), // Jarak antara gambar dan skin tone
                  // Skin tone di sebelah kanan gambar
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Rata kiri untuk teks
                    children: [
                      Text(
                        historyData['skin_tone'] ??
                            'Unknown Skin Tone', // Tampilkan skin tone atau nilai default
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 6, 6, 6),
                          fontWeight: FontWeight.bold,
                          // Warna teks untuk skin tone
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20, // Posisi ikon sampah
              top: 13,
              child: IconButton(
                icon: const Icon(Icons.delete,
                    color: Color.fromARGB(255, 36, 36, 36)),
                onPressed: () async {
                  // Konfirmasi penghapusan
                  final confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Konfirmasi'),
                        content: const Text(
                            'Apakah Anda yakin ingin menghapus riwayat ini?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Hapus'),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmDelete == true) {
                    // Panggil metode untuk menghapus history
                    bool success = await _historyService.deleteHistory(id);
                    if (success) {
                      // Jika berhasil, refresh data history
                      setState(() {
                        _historyFuture = _historyService.getHistory();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Riwayat berhasil dihapus')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Gagal menghapus riwayat')),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
