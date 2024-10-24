import 'package:flutter/material.dart';
import 'detail_info_screen.dart';

class InfoScreen extends StatelessWidget {
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
                'Info',
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold), // Ukuran teks
              ),
              centerTitle: false, // Judul tidak di tengah
            ),
            pinned: false, // Menjaga AppBar tetap terlihat saat digulir
            elevation: 0, // Hilangkan bayangan
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Menambahkan gambar di atas daftar
                _buildImageContainer(),
                SizedBox(height: 10), // Jarak sebelum daftar
                // Daftar item informasi
                _buildInfoItem(
                  context,
                  'Tips Pemilihan Warna',
                  'Berikut adalah beberapa tips pemilihan warna yang sesuai dengan tone kulit Anda.',
                  'Tips pemilihan warna yang tepat dapat membantu Anda menemukan warna yang sesuai dengan tone kulit Anda. Berikut beberapa tips yang dapat Anda lakukan:',
                  Icons.lightbulb,
                ),
                SizedBox(height: 5), // Jarak antar container
                _buildInfoItem(
                  context,
                  'Cara Mengambil Foto',
                  'Berikut adalah tata cara mengambil foto yang tepat untuk hasil yang optimal.',
                  'Mengambil foto yang tepat dapat membantu Anda mendapatkan hasil yang optimal. Berikut beberapa cara yang dapat Anda lakukan:',
                  Icons.camera,
                ),
                SizedBox(height: 5), // Jarak antar container
                _buildInfoItem(
                  context,
                  'Panduan Penggunaan',
                  'Panduan lengkap tentang bagaimana cara menggunakan aplikasi colormatch.',
                  'Panduan penggunaan aplikasi colormatch dapat membantu Anda memahami cara menggunakan aplikasi dengan benar. Berikut beberapa langkah yang dapat Anda lakukan:',
                  Icons.book,
                ),
                SizedBox(height: 5), // Jarak antar container
                _buildInfoItem(
                  context,
                  'Tentang Aplikasi',
                  'Informasi mengenai colormatch dan pengembangannya.',
                  'Aplikasi colormatch adalah aplikasi yang dapat membantu Anda menemukan warna yang sesuai dengan tone kulit Anda. Berikut beberapa informasi tentang aplikasi:',
                  Icons.info,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String title, String description,
      String detailDescription, IconData icon) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 10), // Padding kanan dan kiri
      child: Card(
        elevation: 5, // Tambahkan bayangan pada kartu
        margin: EdgeInsets.all(7), // Menghapus margin pada kartu
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Buat sudut kartu menjadi bulat
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurple, // Ubah warna background avatar
            child: Icon(icon, color: Colors.white), // Ubah warna icon
          ),
          title: Text(title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold)), // Ubah gaya teks judul
          subtitle: Text(description,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey)), // Ubah gaya teks deskripsi
          trailing: Icon(Icons.arrow_forward,
              color: Colors.deepPurple), // Ubah warna icon panah
          onTap: () {
            // Navigasi ke halaman detail
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailInfoScreen(
                  title: title,
                  detailDescription: detailDescription,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageContainer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity, // Lebar penuh
        height: 200, // Tinggi tetap untuk gambar
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Sudut membulat
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(10), // Sudut membulat untuk gambar
          child: FittedBox(
            fit: BoxFit.cover, // Mengatur cara gambar ditampilkan
            child: Image.asset('assets/info.jpg'), // Gambar dari assets
          ),
        ),
      ),
    );
  }
}
