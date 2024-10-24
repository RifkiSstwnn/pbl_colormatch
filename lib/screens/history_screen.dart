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
                // Nama pengguna yang akan ditampilkan
                final String users = 'Alice';

                return Container(
                  height: 140, // Tinggi container diperbesar
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
                  child: Stack(
                    children: [
                      Positioned(
                        left: 60, // Mengatur posisi left sebesar 80
                        top:
                            20, // Mengatur posisi top untuk menyesuaikan vertikal
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'history.jpg', // Path ke gambar
                                width: 70,
                                height: 70,
                                fit: BoxFit
                                    .cover, // Agar gambar menyesuaikan lingkaran
                              ),
                            ),
                            SizedBox(height: 8), // Jarak antara gambar dan teks
                            Text(
                              users, // Nama pengguna di bawah gambar
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 60, // Jarak dari kanan
                        top: 30, // Jarak dari atas
                        child: Column(
                          children: [
                            Text(
                              index == 0
                                  ? 'Summer'
                                  : index == 1
                                      ? 'Autumn'
                                      : index == 2
                                          ? 'Winter'
                                          : 'Spring',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8), // Jarak antara teks dan gambar
                            if (index == 0)
                              Image.asset(
                                'history-summer.png', // Path gambar untuk Summer
                                width: 250,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                            if (index == 1)
                              Image.asset(
                                'history-autumn.png', // Path gambar untuk Autumn
                                width: 255,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                            if (index == 2)
                              Image.asset(
                                'history-winter.png', // Path gambar untuk Winter
                                width: 253,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                            if (index == 3)
                              Image.asset(
                                'history-spring.png', // Path gambar untuk Spring
                                width: 253,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                          ],
                        ),
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
