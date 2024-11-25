import 'package:flutter/material.dart';
import 'package:pbl_colormatch/services/history_service.dart';
import 'result.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<dynamic>?> _historyFuture;
  final HistoryService _historyService = HistoryService();
  bool _isSearching = false; // State variable untuk melacak mode pencarian
  String _searchQuery = ''; // Variabel untuk menyimpan query pencarian
  final FocusNode _searchFocusNode = FocusNode(); // FocusNode untuk TextField

  @override
  void initState() {
    super.initState();
    _historyFuture = _historyService.getHistory();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearching = _searchFocusNode
            .hasFocus; // Update state ketika TextField mendapatkan atau kehilangan fokus
      });
    });
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
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: const Color(0xFF235F60),
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 12,
                ),
              ),
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

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      elevation: 0, // Remove shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child: InkWell(
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
          padding: const EdgeInsets.all(10),
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
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return const SizedBox(
                                height: 70,
                                width: 70,
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
                  icon: const Icon(Icons.delete, color: Color(0xFF235F60)),
                  onPressed: () => _deleteHistory(context, id),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchQuery = ''; // Clear the search query when closing search
        _searchFocusNode.unfocus(); // Unfocus the TextField
      }
    });
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
          final historyCount = historyList.length;

          // Filter history list based on the search query
          final filteredHistoryList = _searchQuery.isEmpty
              ? historyList
              : historyList.where((history) {
                  final nameMatches = history['name']
                      .toString()
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase());
                  final skinToneMatches = history['skin_tone']
                      .toString()
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase());
                  return nameMatches || skinToneMatches;
                }).toList();

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 90.0,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding:
                          const EdgeInsets.only(left: 30, bottom: 15.0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'History',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          // Show the TextField
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 30.0),
                              child: Container(
                                height:
                                    23, // Set a fixed height for the TextField
                                child: TextField(
                                  focusNode: _searchFocusNode,
                                  cursorColor: const Color(0xFF235F60),
                                  style: const TextStyle(fontSize: 11),
                                  decoration: InputDecoration(
                                    hintText: 'Cari...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: const Color(0xFF235F60),
                                          width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: const Color(0xFF235F60),
                                          width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: const Color(0xFF235F60),
                                          width: 1),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _searchQuery = value;
                                    });
                                  },
                                  onSubmitted: (value) {
                                    _toggleSearch();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      centerTitle: false,
                    ),
                    pinned: false,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              const SizedBox(height: 13),
                              _buildHistoryItem(
                                  context, filteredHistoryList[index]),
                            ],
                          );
                        }
                        return _buildHistoryItem(
                            context, filteredHistoryList[index]);
                      },
                      childCount: filteredHistoryList.length,
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Text(
                  'Jumlah History: $historyCount',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchFocusNode.dispose(); // Dispose of the FocusNode
    super.dispose();
  }
}
