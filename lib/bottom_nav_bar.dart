import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Dashboard_Screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;
  late final PageController _pageController = PageController();
  final List<Widget> _pages = [
    Dashboard_Screen(),
    _ProfileListScreen(),
    _AddProfileScreen(),
    _AboutUsScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkTheme ? Colors.grey[850] ?? Colors.grey : Colors.white;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
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
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  Widget _buildNavItem(IconData icon, Color color) =>
      Icon(icon, size: 30, color: color);
}

// Screen for Profile List
class _ProfileListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBarColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[850] ?? Colors.grey
        : Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matrimony Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: appBarColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => print('Search button clicked!'),
          ),
        ],
      ),
      body: const Center(
        child: Text('Profile List', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// Screen for Add Profile
class _AddProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(
    child: Text('Add Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
  );
}

// Screen for About Us
class _AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(
    child: Text('About Us', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
  );
}
