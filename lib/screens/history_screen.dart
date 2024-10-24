import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 90.0, // Tinggi maksimum saat diperluas
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(
                  left: 30, bottom: 16.0), // Tambahkan padding pada title
              title: Text(
                'Scan History',
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold), // Ukuran teks
              ),
              centerTitle: false, // Judul tidak di tengah
            ),
            pinned: false, // AppBar tidak tetap terlihat saat digulir
            elevation: 0, // Hilangkan bayangan
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  height: 120, // Tinggi container
                  margin: EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // Margin untuk jarak
                  decoration: BoxDecoration(
                    color: Colors.white, // Warna latar belakang
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(255, 5, 5, 5).withOpacity(0.2),
                        blurRadius: 5,
                        offset: Offset(0, 3), // Posisi bayangan
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Menggunakan Icon sebagai pengganti gambar
                      SizedBox(width: 10), // Menambahkan margin kiri 5px
                      ClipOval(
                        child: Container(
                          color: Colors.blue, // Warna latar belakang untuk ikon
                          child: Icon(
                            Icons.person, // Ikon profil
                            color: Colors.white, // Warna ikon
                            size: 30, // Ukuran ikon
                          ),
                          width: 50,
                          height: 50,
                        ),
                      ),
                      SizedBox(width: 15), // Jarak antara gambar dan teks
                      // Mengganti teks dengan menambahkan Spring
                      Text(
                        index == 0
                            ? 'Summer'
                            : index == 1
                                ? 'Autumn'
                                : index == 2
                                    ? 'Winter'
                                    : 'Spring',
                        style: TextStyle(fontSize: 16), // Ukuran teks
                      ),
                    ],
                  ),
                );
              },
              childCount: 4, // Jumlah container diubah menjadi 4
            ),
          ),
        ],
      ),
    );
  }
}
