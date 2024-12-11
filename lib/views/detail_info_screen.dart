import 'package:flutter/material.dart';

class DetailInfoScreen extends StatelessWidget {
  final String title;
  final String detailDescription;

  DetailInfoScreen({required this.title, required this.detailDescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar menyerupai WhatsApp
          SliverAppBar(
            expandedHeight: 90.0,
            floating: false,
            pinned: true, // Tetap di atas saat di-scroll
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              centerTitle: false,
            ),
          ),
          // Konten detail deskripsi
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  detailDescription,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
