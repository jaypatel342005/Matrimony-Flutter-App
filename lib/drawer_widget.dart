import 'package:flutter/material.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/theme_notifier.dart';
import 'package:provider/provider.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {


    final themeNotifier = Provider.of<ThemeNotifier>(context);
    ThemeMode themeMode = themeNotifier.getThemeMode;

    // Determine if the system is currently using dark mode
    final bool isSystemDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Determine the current theme label
    String toggleThemeLabel;
    IconData toggleThemeIcon;
    if (themeMode == ThemeMode.system) {
      toggleThemeLabel = isSystemDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode';
      toggleThemeIcon = isSystemDarkMode ? Icons.light_mode : Icons.dark_mode;
    } else {
      toggleThemeLabel = themeMode == ThemeMode.dark ? 'Switch to Light Mode' : 'Switch to Dark Mode';
      toggleThemeIcon = themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode;
    }

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                'Welcome!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          buildDrawerItem(
            context,
            icon: Icons.dashboard,
            label: 'Dashboard',
            color: Colors.blue,
            onTap: () => print('Dashboard clicked!'),
          ),
          buildDrawerItem(
            context,
            icon: Icons.person_add_alt_1,
            label: 'Add Profile',
            color: Colors.green,
            onTap: () => print('Add Profile clicked!'),
          ),
          buildDrawerItem(
            context,
            icon: Icons.list_alt,
            label: 'Profile List',
            color: Colors.orange,
            onTap: () => print('Profile List clicked!'),
          ),
          buildDrawerItem(
            context,
            icon: Icons.favorite,
            label: 'Favorites',
            color: Colors.red,
            onTap: () => print('Favorites clicked!'),
          ),
          buildDrawerItem(
            context,
            icon: Icons.info_outline,
            label: 'About Us',
            color: Colors.purple,
            onTap: () => print('About Us clicked!'),
          ),
          const Divider(),
          ListTile(
            leading: Icon(toggleThemeIcon, color: Colors.grey),
            title: Text(
              toggleThemeLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              themeNotifier.toggleTheme();
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_system_daydream, color: Colors.grey),
            title: const Text(
              'Use System Theme',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              themeNotifier.resetToSystemTheme();
            },
          ),
        ],
      ),
    );
  }

  Widget buildDrawerItem(BuildContext context,
      {required IconData icon,
        required String label,
        required Color color,
        required VoidCallback onTap}) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      splashColor: color.withOpacity(0.3),
      highlightColor: color.withOpacity(0.1),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
