import 'dart:convert';
import 'package:http/http.dart' as http;

// Model user untuk merepresentasikan data user
class User {
  final String uuid;

  User({required this.uuid});

  // Mengonversi data user ke dalam bentuk JSON untuk dikirim ke server
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
    };
  }
}

// Service untuk menambahkan dan memeriksa user
class UserService {
  final String addUserUrl =
      'http://192.168.18.20:5000/add_user'; // Ganti dengan URL endpoint Flask
  final String cekUserUrl =
      'http://192.168.18.20:5000/cek_user'; // Ganti dengan URL endpoint Flask

  // Fungsi untuk menambahkan user baru
  Future<void> addUser(User user) async {
    try {
      // Kirim data user sebagai JSON melalui POST request
      final response = await http.post(
        Uri.parse(addUserUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        print("User berhasil ditambahkan");
      } else {
        print("Gagal menambahkan user: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Fungsi untuk memeriksa apakah user ada
  Future<void> cekUser(String userUuid) async {
    try {
      // Kirim permintaan GET untuk memeriksa user
      final response = await http.get(
        Uri.parse('$cekUserUrl/$userUuid'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Jika user ditemukan, Anda bisa mengolah data yang diterima
        final data = jsonDecode(response.body);
        print("User ditemukan: ${data['uuid']}");
      } else if (response.statusCode == 404) {
        print("User tidak ditemukan. Menambahkan user baru.");
        // Jika user tidak ditemukan, tambahkan user baru
        User newUser = User(uuid: userUuid);
        await addUser(newUser);
      } else {
        print("Gagal memeriksa user: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
