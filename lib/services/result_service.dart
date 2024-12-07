import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbl_colormatch/utils/getUUID.dart';

class ResultService {
  final String baseUrl = 'http://192.168.18.20:5000'; // URL dasar untuk API
  final UUIDService uuidService = UUIDService(); // Instance dari UUIDService

  Future<Map<String, dynamic>?> getResult() async {
    String? uuid = await uuidService.getUUID(); // Mengambil UUID

    if (uuid == null) {
      print("UUID is null, cannot fetch latest history.");
      return null; // Atau bisa throw exception
    }

    final response = await http.get(Uri.parse('$baseUrl/history/latest/$uuid'));

    if (response.statusCode == 200) {
      // Jika server mengembalikan 200 OK, maka parse JSON
      return json.decode(response.body)['latest_history'];
    } else {
      // Jika server tidak mengembalikan 200 OK, lempar exception atau kembalikan null
      print("Failed to fetch latest history: ${response.statusCode}");
      return null;
    }
  }
}
