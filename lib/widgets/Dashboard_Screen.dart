import 'package:flutter/material.dart';
import 'export.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    final navigationController = Provider.of<NavigationController>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              buildDashboardButton(
                index: 0,
                icon: Icons.person_add_alt_1,
                label: 'Add Profile',
                color: Colors.blue,
                isDarkMode: isDarkMode,
                onPressed: () => _delayedNavigation(navigationController, 2),
              ),
              buildDashboardButton(
                index: 1,
                icon: Icons.list_alt,
                label: 'Profile List',
                color: Colors.orange,
                isDarkMode: isDarkMode,
                onPressed: () => _delayedNavigation(navigationController, 1),
              ),
              buildDashboardButton(
                index: 2,
                icon: Icons.info_outline,
                label: 'About Us',
                color: Colors.purple,
                isDarkMode: isDarkMode,
                onPressed: () => _delayedNavigation(navigationController, 3),
              ),
              buildDashboardButton(
                index: 3,
                icon: Icons.favorite,
                label: 'Favorites',
                color: Colors.red,
                isDarkMode: isDarkMode,
                onPressed: () => print('Favorites clicked!'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        spacing: 12,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.person_add_alt_1, color: Colors.white),
            backgroundColor: Colors.blue,
            label: 'Add Profile',
            onTap: () => _delayedNavigation(navigationController, 2),
          ),
          SpeedDialChild(
            child: const Icon(Icons.list_alt, color: Colors.white),
            backgroundColor: Colors.orange,
            label: 'Profile List',
            onTap: () => _delayedNavigation(navigationController, 1),
          ),
          SpeedDialChild(
            child: const Icon(Icons.favorite, color: Colors.white),
            backgroundColor: Colors.red,
            label: 'Favorites',
            onTap: () => print('Favorites selected'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.info_outline, color: Colors.white),
            backgroundColor: Colors.purple,
            label: 'About Us',
            onTap: () => _delayedNavigation(navigationController, 3),
          ),
        ],
      ),
    );
  }


  void _delayedNavigation(NavigationController navigationController, int index) {
    Future.delayed(const Duration(milliseconds: 160), () {
      navigationController.setIndex(index);
    });
  }

  Widget buildDashboardButton({
    required int index,
    required IconData icon,
    required String label,
    required Color color,
    required bool isDarkMode,
    required VoidCallback onPressed,
  }) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: isDarkMode
              ? (isHovered ? color.withOpacity(0.8) : Colors.grey[800])
              : (isHovered ? color.withOpacity(0.8) : Colors.white),
          shadowColor: isDarkMode
              ? (isHovered ? Colors.white.withOpacity(0.4) : Colors.white.withOpacity(0.2))
              : (isHovered ? color.withOpacity(0.7) : Colors.grey.withOpacity(0.5)),
          elevation: isHovered ? 12 : 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(18),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: isHovered ? 50 : 40,
              width: isHovered ? 50 : 40,
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? (isHovered ? color : Colors.white) : (isHovered ? color : Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
