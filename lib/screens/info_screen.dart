import 'package:flutter/material.dart';
import 'detail_info_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: ListView(
        children: [
          _buildInfoItem(
            context, 
            'Tips Pemilihan Warna', 
            'Berikut adalah beberapa tips pemilihan warna yang sesuai dengan tone kulit Anda.', 
            Icons.lightbulb
          ),
          _buildInfoItem(
            context, 
            'Cara Mengambil Foto', 
            'Berikut adalah tata cara mengambil foto yang tepat untuk hasil yang optimal.', 
            Icons.camera
          ),
          _buildInfoItem(
            context, 
            'Panduan Penggunaan', 
            'Panduan lengkap tentang bagaimana cara menggunakan aplikasi colormatch.', 
            Icons.book
          ),
          _buildInfoItem(
            context, 
            'Tentang Aplikasi', 
            'Informasi mengenai colormatch dan pengembangannya.', 
            Icons.info
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String title, String description, IconData icon) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(icon),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        // Navigasi ke halaman detail
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailInfoScreen(
              title: title,
              description: description,
            ),
          ),
        );
      },
    );
  }
}
