import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://127.0.0.1:5000/api";

  Future<String> testApi() async {
    final response = await http.get(Uri.parse("$baseUrl/test"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      throw Exception("Failed to connect to API");
    }
  }
}
