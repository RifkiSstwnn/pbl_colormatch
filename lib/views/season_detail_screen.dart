import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkinToneDetailScreen extends StatelessWidget {
  final String season;
  final String description;
  final List<Color> skinColors;
  final List<Color> eyeColors;
  final List<Color> eyebrowColors;
  final List<Color> bestColors;
  final String imagePath;

  const SkinToneDetailScreen({
    super.key,
    required this.season,
    required this.description,
    required this.skinColors,
    required this.eyeColors,
    required this.eyebrowColors,
    required this.bestColors,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          season,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Color(0xFF235F60),
                    width: 3.0,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                labelColor: const Color(0xFF235F60),
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    child: Text(
                      'Description',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Colors',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description,
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle('Skin'),
                              _buildColorRow(skinColors),
                              const SizedBox(height: 20),
                              _buildSectionTitle('Eyes'),
                              _buildColorRow(eyeColors),
                              const SizedBox(height: 20),
                              _buildSectionTitle('Eyebrow'),
                              _buildColorRow(eyebrowColors),
                              const SizedBox(height: 20),
                              _buildSectionTitle('Best Color (Outfit)'),
                              _buildColorRow(bestColors),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildColorRow(List<Color> colors) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(colors.length, (index) {
        return Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: colors[index],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
          ),
        );
      }),
    );
  }
}

class UnderlineTabIndicator extends Decoration {
  final BorderSide borderSide;
  final EdgeInsets insets;

  const UnderlineTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlineTabIndicatorPainter(this, onChanged);
  }
}

class _UnderlineTabIndicatorPainter extends BoxPainter {
  _UnderlineTabIndicatorPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  final UnderlineTabIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final Rect indicatorRect = Rect.fromLTWH(
      rect.left + decoration.insets.left,
      rect.bottom - decoration.borderSide.width - decoration.insets.bottom,
      rect.width - decoration.insets.horizontal,
      decoration.borderSide.width,
    );
    final Paint paint = decoration.borderSide.toPaint()
      ..color = decoration.borderSide.color;
    canvas.drawRect(indicatorRect, paint);
  }
}
