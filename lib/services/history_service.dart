import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbl_colormatch/utils/getUUID.dart'; // Import UUIDService

class HistoryService {
  final String baseUrl = 'http://192.168.0.107:5000'; // URL dasar untuk API
  final UUIDService uuidService = UUIDService(); // Instance dari UUIDService

  Future<List<dynamic>?> getHistory() async {
    String? uuid = await uuidService.getUUID(); // Mengambil UUID

    if (uuid == null) {
      print("UUID is null, cannot fetch history.");
      return null; // Atau bisa throw exception
    }

    final response = await http.get(Uri.parse('$baseUrl/history/$uuid'));

    if (response.statusCode == 200) {
      // Jika server mengembalikan 200 OK, parse JSON dan ambil all_history
      return json.decode(response.body)['all_history'];
    } else {
      // Jika server tidak mengembalikan 200 OK, lempar exception atau kembalikan null
      print("Failed to fetch history: ${response.statusCode}");
      return null;
    }
  }

  Future<bool> editName(String id, String newName) async {
    final response = await http.put(
      Uri.parse('$baseUrl/history/edit_name/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': newName}),
    );

    if (response.statusCode == 200) {
      return true; // Berhasil mengupdate nama
    } else {
      print("Failed to update name: ${response.statusCode}");
      return false; // Gagal mengupdate nama
    }
  }

  // Menambahkan metode untuk menghapus history
  Future<bool> deleteHistory(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/history/delete/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true; // Berhasil menghapus history
    } else {
      print("Failed to delete history: ${response.statusCode}");
      return false; // Gagal menghapus history
    }
  }
}
