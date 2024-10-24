import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    // Handle file (misalnya, menampilkan gambar yang dipilih)
  }

  Future<void> _takePicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    // Handle file (misalnya, menampilkan gambar yang diambil)
  }

  final List<Map<String, String>> _imageList = [
    {
      'image': 'assets/flat-penjelasan1.png',
      'caption':
          'Ambil foto wajah Anda dengan pencahayaan yang baik untuk hasil terbaik.'
    },
    {
      'image': 'assets/flat-penjelasan2.png',
      'caption': 'Pastikan wajah Anda terlihat jelas.'
    },
    {
      'image': 'assets/flat-penjelasan3.png',
      'caption': 'Gunakan latar belakang yang sederhana.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 90.0, // Tinggi maksimum saat diperluas
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 30, bottom: 16.0),
              title: Text('Pindai',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold)), // Ukuran teks
              centerTitle: false,
            ),
            pinned: false, // Menjaga AppBar tetap terlihat saat digulir
            elevation: 0, // Hilangkan bayangan
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final image = _imageList[index]['image'];
                final caption = _imageList[index]['caption'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Atur alignment teks
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width *
                            0.35, // Sesuaikan lebar gambar berdasarkan lebar layar
                        height: 150, // Kurangi tinggi gambar
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10), // Sudut membulat
                          image: DecorationImage(
                            image: AssetImage(
                                image!), // Pastikan gambar ada di assets
                            fit: BoxFit
                                .cover, // Mengatur cara gambar ditampilkan
                          ),
                        ),
                      ),
                      SizedBox(width: 16), // Jarak antara gambar dan teks
                      Expanded(
                        // Gunakan Expanded untuk teks agar tidak overflow
                        child: Text(
                          caption!, // Teks keterangan
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: _imageList.length, // Jumlah item di ListView
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.camera_alt), // Ikon kamera
              label: Text('Buka Kamera'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 60), // Lebar dan tinggi tombol
                textStyle: TextStyle(fontSize: 16), // Ukuran teks tombol
              ),
            ),
            ElevatedButton.icon(
              onPressed: _pickImageFromGallery,
              icon: Icon(Icons.photo_library), // Ikon galeri
              label: Text('Pilih dari Galeri'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 60), // Lebar dan tinggi tombol
                textStyle: TextStyle(fontSize: 16), // Ukuran teks tombol
              ),
            ),
          ],
        ),
      ),
    );
  }
}
