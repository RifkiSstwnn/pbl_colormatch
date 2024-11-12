import 'package:shared_preferences/shared_preferences.dart';

class UUIDService {
  static const String _uuidKey = 'userUUID';

  // Fungsi untuk mengambil UUID dari Shared Preferences
  Future<String?> getUUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_uuidKey); // Mengembalikan UUID jika ada
  }
}
