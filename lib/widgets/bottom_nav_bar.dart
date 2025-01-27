import 'package:flutter/material.dart';
import 'export.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Provider.of<NavigationController>(context);
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkTheme ? Colors.grey[850] ?? Colors.grey : Colors.white;

    final pages = [
      Dashboard(),
      ProfileList(),
      AddProfile(),
      AboutUs(),
    ];

    return Scaffold(
      body: PageView(
        controller: navigationController.pageController,
        onPageChanged: navigationController.setIndex,
        children: pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: navigationController.currentIndex,
        height: 60.0,
        items: [
          _buildNavItem(Icons.dashboard, Colors.blue),
          _buildNavItem(Icons.list_alt, Colors.orange),
          _buildNavItem(Icons.person_add, Colors.green),
          _buildNavItem(Icons.info, Colors.purple),
        ],
        color: bgColor,
        buttonBackgroundColor: bgColor,
        backgroundColor: isDarkTheme ? Colors.black54 : Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        onTap: navigationController.setIndex,
      ),
    );
  }

  Widget _buildNavItem(IconData icon, Color color) =>
      Icon(icon, size: 30, color: color);
}
