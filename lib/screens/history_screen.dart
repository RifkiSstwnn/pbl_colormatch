import 'package:flutter/material.dart';
import 'package:pbl_colormatch/services/history_service.dart';
import 'result.dart'; // Mengimpor ResultDialog

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<dynamic>?> _historyFuture;
  final HistoryService _historyService = HistoryService();

  @override
  void initState() {
    super.initState();
    _historyFuture =
        _historyService.getHistory(); // Ambil seluruh history dari service
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>?>(
        // Corrected the Future type to List<dynamic>?
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No history found.'));
          }

          final historyList = snapshot.data!; // Ambil seluruh data history

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 90.0,
                flexibleSpace: const FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 30, bottom: 16.0),
                  title: Text(
                    'Scan History',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  centerTitle: false,
                ),
                pinned: false,
                elevation: 0,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _buildHistoryItem(context, historyList[index]);
                  },
                  childCount: historyList.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHistoryItem(
      BuildContext context, Map<String, dynamic> historyData) {
    return InkWell(
      onTap: () {
        // Menampilkan ResultDialog saat item di klik
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ResultDialog(latestHistory: historyData);
          },
        );
      },
      child: Container(
        height: 140,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 245, 245),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 30,
              top: 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      historyData['foto_output'], // URL foto output dari API
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return const SizedBox(
                          height: 120,
                          width: 120,
                          child:
                              Center(child: Text('Gambar tidak dapat dimuat')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 120,
              top: 30,
              child: Column(
                children: [
                  Text(
                    historyData['skin_tone'] ??
                        'Unknown Skin Tone', // Tampilkan skin tone atau nilai default
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
