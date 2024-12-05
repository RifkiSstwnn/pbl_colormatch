import 'package:flutter/material.dart';

class DetailInfoScreen extends StatelessWidget {
  final String title;
  final String detailDescription;

  DetailInfoScreen({required this.title, required this.detailDescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0, // Memperlebar area untuk judul
        leading: SizedBox.shrink(), // Menghilangkan leading (back button)
        titleSpacing: 0, // Memperkecil jarak antara judul dan tepi
        title: Align(
          alignment: Alignment.centerLeft, // Mengatur posisi judul ke kiri
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16.0), // Tambahkan padding kiri
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri untuk teks
          children: [
            SizedBox(
                height:
                    10), // Tambahkan jarak antara judul dan detail deskripsi
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // Buat sudut container menjadi bulat
                color: Colors.white, // Ubah warna background container
              ),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                detailDescription,
                style:
                    TextStyle(fontSize: 16), // Ubah gaya teks detail deskripsi
              ),
            ),
          ],
        ),
      ),
    );
  }
}
