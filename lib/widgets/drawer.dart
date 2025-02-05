import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'favoritepage.dart';
import 'userdata.dart';
import 'export.dart';

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
    final bool isSystemDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Determine the current theme label and icon
    String toggleThemeLabel;
    IconData toggleThemeIcon;
    if (themeMode == ThemeMode.system) {
      toggleThemeLabel =
      isSystemDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode';
      toggleThemeIcon =
      isSystemDarkMode ? Icons.light_mode : Icons.dark_mode;
    } else {
      toggleThemeLabel = themeMode == ThemeMode.dark
          ? 'Switch to Light Mode'
          : 'Switch to Dark Mode';
      toggleThemeIcon = themeMode == ThemeMode.dark
          ? Icons.light_mode
          : Icons.dark_mode;
    }

    return SafeArea(
      minimum: const EdgeInsets.all(10),
      bottom: true,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2196F3), // Blue shade
                    Color(0xFF64B5F6), // Lighter blue shade
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Image.asset(
                        'assets/images/profile_photo.png',
                        height: 85,
                        width: 85,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Welcome !',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Matches the header background
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildDrawerItem(
              context,
              icon: Icons.dashboard,
              label: 'Dashboard',
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard()
                  ),
                );
              },
            ),
            buildDrawerItem(
              context,
              icon: Icons.person_add_alt_1,
              label: 'Add Profile',
              color: Colors.green,
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUserForm(),
                  ),
                );
              },
            ),
            buildDrawerItem(
              context,
              icon: Icons.list_alt,
              label: 'Profile List',
              color: Colors.orange,
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserListPage(),
                  ),
                );
              },
            ),
            buildDrawerItem(
              context,
              icon: Icons.favorite,
              label: 'Favorites',
              color: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()),
                );
              },
            ),
            buildDrawerItem(
              context,
              icon: Icons.info_outline,
              label: 'About Us',
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(toggleThemeIcon, color: Colors.grey),
              title: Text(
                toggleThemeLabel,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                themeNotifier.toggleTheme();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_system_daydream,
                  color: Colors.grey),
              title: const Text(
                'Use System Theme',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                themeNotifier.resetToSystemTheme();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color color,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context); // Close the drawer
        onTap(); // Call the provided callback
      },
      splashColor: color.withOpacity(0.3),
      highlightColor: color.withOpacity(0.1),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
