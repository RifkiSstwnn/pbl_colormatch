import 'package:flutter/material.dart';
import 'package:pbl_colormatch/services/history_service.dart';
import 'result.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

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
    _historyFuture = _historyService.getHistory();
  }

  Future<void> _deleteHistory(BuildContext context, int id) async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Confirm',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          content: const Text('Are you sure you want to delete this history?'),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF235F60),
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        bool success = await _historyService.deleteHistory(id);
        if (success) {
          setState(() {
            _historyFuture = _historyService.getHistory();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('History deleted successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete history')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  List<Color> _parseColorPalette(dynamic colorPalette) {
    try {
      if (colorPalette is String) {
        List<dynamic> paletteList = jsonDecode(colorPalette);
        return paletteList.map((hex) {
          return Color(int.parse(hex.toString().replaceFirst('#', '0xFF')));
        }).toList();
      }

      if (colorPalette is List<dynamic>) {
        return colorPalette.map((hex) {
          return Color(int.parse(hex.toString().replaceFirst('#', '0xFF')));
        }).toList();
      }
    } catch (e) {
      debugPrint('Error parsing color_palette: $e');
    }
    return [];
  }

  Widget _buildHistoryItem(
      BuildContext context, Map<String, dynamic> historyData) {
    int id = historyData['id'];

    List<Color> colorPalette = _parseColorPalette(historyData['color_palette']);

    return InkWell(
      onTap: () {
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
          color: const Color.fromARGB(255, 245, 244, 244),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 30,
              top: 18,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      ClipOval(
                        child: Image.network(
                          historyData['foto_output'] ?? '',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const SizedBox(
                              height: 80,
                              width: 80,
                              child: Center(
                                  child: Text('Image could not be loaded')),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        historyData['name'] ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 35),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        historyData['skin_tone'] ?? 'Unknown Skin Tone',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 6, 6, 6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: colorPalette.take(5).map((color) {
                          return Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              top: 13,
              child: IconButton(
                icon: const Icon(Icons.delete,
                    color: Color.fromARGB(255, 36, 36, 36)),
                onPressed: () => _deleteHistory(context, id),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>?>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No history found.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final historyList = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 90.0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                      left: 30.0, bottom: 16.0), // Menambahkan padding
                  title: Text(
                    'History',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                elevation: 0,
                automaticallyImplyLeading: false,
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
}
