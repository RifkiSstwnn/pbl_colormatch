import 'package:flutter/material.dart';

class DetailInfoScreen extends StatelessWidget {
  final String title;
  final String detailDescription;

  DetailInfoScreen({required this.title, required this.detailDescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri untuk teks
          children: [
            SizedBox(
                height:
                    32), // Tambahkan jarak antara judul dan detail deskripsi
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // Buat sudut container menjadi bulat
                color: Colors.white, // Ubah warna background container
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Ubah warna bayangan
                    spreadRadius: 2, // Ubah ukuran bayangan
                    blurRadius: 5, // Ubah ukuran bayangan
                  ),
                ],
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
