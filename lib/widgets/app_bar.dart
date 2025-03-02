import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onSearchTap;
  final VoidCallback? onSortTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onSearchTap,
    this.onSortTap,
  });

  bool get _shouldShowSearchIcon {
    // Only show search icon on these specific pages
    return title == "Profile List" || title == "Favorites";
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Stack(
        children: [
          SizedBox(
            height: preferredSize.height + 40,
            child: CustomPaint(
              size: Size(
                  MediaQuery.of(context).size.width, preferredSize.height + 40),
              painter: AppBarPainter(),
            ),
          ),
          PreferredSize(
            preferredSize: preferredSize,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: true,
              flexibleSpace: const SizedBox.shrink(),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              scrolledUnderElevation: 0,
              actions: _shouldShowSearchIcon
                  ? [
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: onSearchTap,
                      ),
                      if (title == "Profile List")
                        IconButton(
                          icon: const Icon(
                            Icons.sort,
                            color: Colors.white,
                          ),
                          onPressed: onSortTap,
                        ),
                      const SizedBox(width: 8),
                    ]
                  : null,
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [Colors.white, Colors.cyanAccent],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 30)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40);
}

class AppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_1 = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.red, Colors.redAccent, Colors.pinkAccent, Colors.pink],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Left curve
    Path path_1 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * .08, 0.0)
      ..cubicTo(
          size.width * 0.04,
          0.0, // x1, y1
          0.0,
          size.height * 0.04, // x2, y2
          0.0,
          size.height * 0.1 // x3, y3
          );

    // Right curve
    Path path_2 = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width * .92, 0.0)
      ..cubicTo(
          size.width * .96,
          0.0, // x1, y1
          size.width,
          size.height * 0.04, // x2, y2
          size.width,
          size.height * 0.1 // x3, y3
          );

    // Top line
    Path path_3 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0);

    // Fill the entire area
    Path mainPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.9)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 1.1,
        0,
        size.height * 0.9,
      )
      ..close();

    // Draw all paths
    canvas.drawPath(mainPath, paint_1);
    canvas.drawPath(path_1, paint_1);
    canvas.drawPath(path_2, paint_1);
    canvas.drawPath(path_3, paint_1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
