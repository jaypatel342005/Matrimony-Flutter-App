import 'package:matrimony_flutter_app/widgets/favoritepage.dart';
import 'export.dart';
import 'package:matrimony_flutter_app/services/navigation_service.dart';
import 'dashboard_charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Matrimony Dashboard',
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 8.4),
            const DashboardCharts(),
            Container(
              margin: const EdgeInsets.only(top: 0),
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 22,
                mainAxisSpacing: 32,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildDashboardButton(
                    index: 0,
                    imagePath: 'assets/images/add_profile.png',
                    label: 'Add Profile',
                    color: Colors.blue,
                    shadowColor: Colors.blueAccent,
                    isDarkMode: isDarkMode,
                    imageHeight: 80,
                    imageWidth: 70,
                    textSpacing: 21, // Custom spacing
                    clipper: WavyClipper1(),
                    onPressed: () async {
                      try {
                        await NavigationService.navigateWithFade(
                            const AddEditForm());
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Navigation error occurred'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    },
                  ),
                  buildDashboardButton(
                    index: 1,
                    imagePath: 'assets/images/profilelist.png',
                    label: 'Profile List',
                    color: Colors.orange,
                    shadowColor: Colors.orange,
                    isDarkMode: isDarkMode,
                    imageHeight: 95,
                    imageWidth: 85,
                    textSpacing: 11, // Custom spacing
                    clipper: WavyClipper2(),
                    onPressed: () async {
                      try {
                        await NavigationService.navigateWithFade(
                            const ProfileList());
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Navigation error occurred'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    },
                  ),
                  buildDashboardButton(
                    index: 2,
                    imagePath: 'assets/images/aboutus.png',
                    label: 'About Us',
                    color: Colors.purple,
                    shadowColor: Colors.deepPurple,
                    isDarkMode: isDarkMode,
                    imageHeight: 90,
                    imageWidth: 80,
                    textSpacing: 18, // Custom spacing
                    clipper: WavyClipper3(),
                    onPressed: () async {
                      try {
                        await NavigationService.navigateWithFade(AboutUsPage());
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Navigation error occurred'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    },
                  ),
                  buildDashboardButton(
                    index: 3,
                    imagePath: 'assets/images/like.png',
                    label: 'Favorites',
                    color: Colors.red,
                    shadowColor: Colors.redAccent,
                    isDarkMode: isDarkMode,
                    imageHeight: 110, // Larger for better balance
                    imageWidth: 100,
                    textSpacing: 0, // Custom spacing
                    clipper: WavyClipper4(),
                    onPressed: () async {
                      try {
                        await NavigationService.navigateWithFade(
                            const FavoritesPage());
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Navigation error occurred'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDashboardButton({
    required int index,
    required String imagePath,
    required String label,
    required Color color,
    required Color shadowColor,
    required bool isDarkMode,
    required double imageHeight,
    required double imageWidth,
    required double textSpacing, // Custom spacing for each card
    required CustomClipper<Path> clipper,
    required VoidCallback onPressed,
  }) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: isHovered
                  ? [color.withOpacity(0.9), Colors.white]
                  : [color, Colors.grey[300]!.withOpacity(0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? shadowColor.withOpacity(0.10)
                    : shadowColor.withOpacity(0.6),
                blurRadius: isHovered ? 25 : 18,
                offset: const Offset(0, 9),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Stack(
              children: [
                ClipPath(
                  clipper: clipper,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withOpacity(0.4),
                          Colors.white.withOpacity(0.2)
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: isHovered ? imageHeight + 10 : imageHeight,
                        width: isHovered ? imageWidth + 10 : imageWidth,
                        child: Image.asset(imagePath, fit: BoxFit.contain),
                      ),
                      SizedBox(height: textSpacing), // Custom spacing applied
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? (isHovered ? color : Colors.white)
                              : (isHovered ? color : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Unique WavyClipper Designs for Each Card
class WavyClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 1.3, size.width, size.height * 0.6);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WavyClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 1.2, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WavyClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.55);
    path.quadraticBezierTo(
        size.width * 0.4, size.height * 1.1, size.width, size.height * 0.55);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WavyClipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 1.4, size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
