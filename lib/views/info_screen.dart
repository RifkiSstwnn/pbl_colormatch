import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'detail_info_screen.dart';
import 'package:pbl_colormatch/services/user_service.dart';

class InfoScreen extends StatelessWidget {
  final UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  expandedHeight: 90.0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 30, bottom: 15.0),
                    title: Text('Info',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    centerTitle: false,
                  ),
                  pinned: false,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 10), // Jarak sebelum daftar
                      _buildInfoItem(
                        context,
                        'Tips Pemilihan Warna',
                        'Berikut adalah beberapa tips pemilihan warna yang sesuai dengan tone kulit Anda.',
                        'Tips pemilihan warna yang tepat dapat membantu Anda menemukan warna yang sesuai dengan tone kulit Anda. Berikut beberapa tips yang dapat Anda lakukan:',
                        Icons.lightbulb,
                      ),
                      _buildInfoItem(
                        context,
                        'Cara Mengambil Foto',
                        'Berikut adalah tata cara mengambil foto yang tepat untuk hasil yang optimal.',
                        'Mengambil foto yang tepat dapat membantu Anda mendapatkan hasil yang optimal. Berikut beberapa cara yang dapat Anda lakukan:',
                        Icons.camera,
                      ),
                      _buildInfoItem(
                        context,
                        'Panduan Penggunaan',
                        'Panduan lengkap tentang bagaimana cara menggunakan aplikasi colormatch.',
                        'Panduan penggunaan aplikasi colormatch dapat membantu Anda memahami cara menggunakan aplikasi dengan benar. Berikut beberapa langkah yang dapat Anda lakukan:',
                        Icons.book,
                      ),
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
          ),
          // Kontainer untuk tombol hapus akun
          Container(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 233, 68, 56),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                bool confirm = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Konfirmasi Penghapusan'),
                      content: const Text(
                          'Apakah Anda yakin ingin menghapus semua data aplikasi?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Ya, Hapus'),
                        ),
                      ],
                    );
                  },
                );

                if (confirm) {
                  // Hapus data aplikasi
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  await userService.deleteUser(); // Hapus data user dari backend
                  await prefs.clear(); // Hapus data lokal

                  // Keluar dari aplikasi
                  SystemNavigator.pop();
                }
              },
              child: const Text(
                'Hapus Akun',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
              ),
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
        elevation:
            0, // Ubah elevasi kartu menjadi 0 untuk menghilangkan shadows
        color: Colors.white, // Ubah warna kartu menjadi putih
        margin: EdgeInsets.all(6), // Menghapus margin pada kartu
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Buat sudut kartu menjadi bulat
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFF235F60),
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
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Color(0xffb1e33d),
          ), // Ubah warna icon panah
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
}