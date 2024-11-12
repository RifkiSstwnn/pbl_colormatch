import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbl_colormatch/utils/getUUID.dart'; // Import UUIDService

class HistoryService {
  final String baseUrl = 'http://192.168.59.203:5000'; // URL dasar untuk API
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
}

