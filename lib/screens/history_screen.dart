import 'package:flutter/material.dart';
import 'package:pbl_colormatch/services/history_service.dart';
import 'result.dart'; // Import ResultDialog
import 'package:google_fonts/google_fonts.dart';

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
        _historyService.getHistory(); // Fetch all history from service
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>?>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'History', // Title when there is no history
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                      height: 20), // Spacing between title and message
                  const Text(
                    'No history found.',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }

          final historyList = snapshot.data!; // Retrieve all history data

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 90.0, // Updated height
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                      left: 30, bottom: 16.0), // Updated padding
                  title: Text(
                    'History', // Updated title
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ), // Updated style
                  ),
                  centerTitle: false, // Ensure title is left-aligned
                ),
                pinned: false, // Set pinned to false
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

  Widget _buildHistoryItem(
      BuildContext context, Map<String, dynamic> historyData) {
    int id = historyData['id']; // Get ID from historyData

    return InkWell(
      onTap: () {
        // Show ResultDialog when item is clicked
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
                  // Column for image and name below it
                  Column(
                    children: [
                      // Image
                      ClipOval(
                        child: Image.network(
                          historyData['foto_output'] ??
                              '', // Image URL from API
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
                      const SizedBox(height: 5), // Space between image and name
                      // Name below the image
                      Text(
                        historyData['name'] ??
                            'Unknown', // Show name or default value
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                      width: 55), // Space between image and skin tone
                  // Skin tone to the right of the image
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        historyData['skin_tone'] ??
                            'Unknown Skin Tone', // Show skin tone or default value
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 6, 6, 6),
                          fontWeight:
                              FontWeight.bold, // Text color for skin tone
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20, // Position of delete icon
              top: 13,
              child: IconButton(
                icon: const Icon(Icons.delete,
                    color: Color.fromARGB(255, 36, 36, 36)),
                onPressed: () async {
                  // Confirm deletion
                  final confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          'Confirm',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                            'Are you sure you want to delete this history?'),
                        actions: [
                          // TextButton(
                          //   onPressed: () => Navigator.of(context).pop(false),
                          //   child: const Text('Cancel'),
                          // ),
                          OutlinedButton.icon(
                            onPressed: () => Navigator.of(context).pop(false),
                            label: Text(
                              'Cancel',
                              style: TextStyle(
                                color: const Color(0xFF235F60),
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 12, // Reduced font size
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize:
                                  const Size(60, 40), // Reduced minimum size
                              side: const BorderSide(
                                  color: Color(0xFF235F60)), // Border color
                              backgroundColor:
                                  Colors.white, // Button background color
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
                    // Call method to delete history
                    bool success = await _historyService.deleteHistory(id);
                    if (success) {
                      // If successful, refresh history data
                      setState(() {
                        _historyFuture = _historyService.getHistory();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('History deleted successfully')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Failed to delete history')),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
