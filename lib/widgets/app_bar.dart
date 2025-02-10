import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: preferredSize.height + 40,
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width, preferredSize.height + 40),
            painter: AppBarPainter(),
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        Positioned(
          bottom: 30, // Moves the title downward
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40);
}

class AppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = const LinearGradient(
        // colors: [Colors.blueAccent,Colors.blue,Colors.lightBlueAccent, Colors.lightBlueAccent],
      colors: [Colors.red,Colors.redAccent, Colors.pinkAccent,Colors.pink],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 1.2,
      size.width, size.height * 0.8,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
