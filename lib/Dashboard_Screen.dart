import 'package:flutter/material.dart';
import 'drawer_widget.dart'; // Import the CustomDrawer file
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Dashboard_Screen extends StatefulWidget {
  const Dashboard_Screen({super.key});

  @override
  State<Dashboard_Screen> createState() => _Dashboard_ScreenState();
}

class _Dashboard_ScreenState extends State<Dashboard_Screen> {
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Matrimony Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(), // Use the custom drawer
      body: SafeArea(
        minimum: const EdgeInsets.all(12.0),
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              buildDashboardButton(
                index: 0,
                icon: Icons.person_add_alt_1,
                label: 'Add Profile',
                color: Colors.blue,
                isDarkMode: isDarkMode,
                onPressed: () => print('Add Profile clicked!'),
              ),
              buildDashboardButton(
                index: 1,
                icon: Icons.list_alt,
                label: 'Profile List',
                color: Colors.orange,
                isDarkMode: isDarkMode,
                onPressed: () => print('Profile List clicked!'),
              ),
              buildDashboardButton(
                index: 2,
                icon: Icons.info_outline,
                label: 'About Us',
                color: Colors.purple,
                isDarkMode: isDarkMode,
                onPressed: () => print('About Us clicked!'),
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
            onTap: () => print('Add Profile selected'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.list_alt, color: Colors.white),
            backgroundColor: Colors.orange,
            label: 'Profile List',
            onTap: () => print('Profile List selected'),
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
            onTap: () => print('About Us selected'),
          ),
        ],
      ),
    );
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
