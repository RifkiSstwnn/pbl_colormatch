import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pbl_colormatch/utils/getUUID.dart'; // Import UUIDService

class UploadService {
  final String apiUrl = 'http://192.168.18.20:5000//upload_image';

  // Fungsi untuk mengupload gambar
  Future<Map<String, dynamic>?> uploadImage(File file) async {
    UUIDService uuidService = UUIDService(); // Inisialisasi UUIDService
    String? uuid = await uuidService.getUUID(); // Mengambil UUID

    if (uuid == null) {
      print('UUID not found');
      return null; // Menyatakan tidak ada UUID, sehingga upload dibatalkan
    }

    try {
      Dio dio = Dio();
      FormData formData = await _createFormData(file, uuid);

      // Mengirim data menggunakan Dio
      var response = await dio.post(apiUrl, data: formData);

      // Tambahkan log untuk mencetak respons
      print('Response: ${response.data}');

      if (response.statusCode == 200) {
        var jsonData = response.data;
        return {
          'skin_tone': jsonData['skin_tone'],
          'color_palette': jsonData['color_palette'],
        };
      } else {
        print(
            'Failed to upload image: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Fungsi untuk membuat FormData
  Future<FormData> _createFormData(File file, String uuid) async {
    if (kIsWeb) {
      // Jika menjalankan di web, menggunakan `fromBytes`
      Uint8List fileBytes = await file.readAsBytes();
      return FormData.fromMap({
        'uuid': uuid,
        'file': MultipartFile.fromBytes(fileBytes,
            filename: file.path.split('/').last),
      });
    } else {
      // Jika menjalankan di perangkat asli (Android/iOS), menggunakan `fromFile`
      return FormData.fromMap({
        'uuid': uuid,
        'file': await MultipartFile.fromFile(file.path),
      });
    }
  }
}
