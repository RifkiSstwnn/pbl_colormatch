import 'package:flutter/material.dart';
import '../models/history_model.dart';
import '../services/history_service.dart';

class HistoryProvider with ChangeNotifier {
  List<History> _histories = [];

  Future<bool> editName(String id, String newName) async {
    try {
      final historyIndex = _histories.indexWhere((h) => h.id == id);
      if (historyIndex == -1) {
        print('History with ID $id not found'); // Debugging
        return false; // ID tidak ditemukan
      }

      _histories[historyIndex].name = newName; // Perbarui nama
      notifyListeners(); // Notifikasi perubahan
      return true; // Berhasil
    } catch (e) {
      print('Error updating name: $e'); // Debugging
      return false; // Gagal
    }
  }
}
