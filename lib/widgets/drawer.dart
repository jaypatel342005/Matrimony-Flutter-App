import 'favoritepage.dart';
import 'export.dart';
import '../services/navigation_service.dart';
import '../services/shared_prefs.dart';
// final List<List<Color>> cardGradients = [
//   [Colors.blue.shade500, Colors.indigo.shade100],
//   [Colors.deepPurple.shade500, Colors.blueAccent.shade100],
//   [Colors.indigo.shade500, Colors.purple.shade100],
//   [Colors.purple.shade500, Colors.blueGrey.shade100],
//   [Colors.blueAccent.shade400, Colors.deepPurpleAccent.shade100],
//   [Colors.blueGrey.shade500, Colors.indigoAccent.shade100],
//   [Colors.indigoAccent.shade400, Colors.purpleAccent.shade100],
//   [Colors.purpleAccent.shade400, Colors.blue.shade100],
//   [Colors.indigo.shade500, Colors.blueAccent.shade100],
//   [Colors.deepPurpleAccent.shade400, Colors.blueGrey.shade100],
//   [Colors.blue.shade500, Colors.purpleAccent.shade100],
//   [Colors.indigoAccent.shade400, Colors.deepPurple.shade100],
// ];

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    ThemeMode themeMode = themeNotifier.currentThemeMode;

    // Determine if the system is currently using dark mode
    final bool isSystemDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Determine the current theme label and icon
    String toggleThemeLabel;
    IconData toggleThemeIcon;
    if (themeMode == ThemeMode.system) {
      toggleThemeLabel =
          isSystemDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode';
      toggleThemeIcon = isSystemDarkMode ? Icons.light_mode : Icons.dark_mode;
    } else {
      toggleThemeLabel = themeMode == ThemeMode.dark
          ? 'Switch to Light Mode'
          : 'Switch to Dark Mode';
      toggleThemeIcon =
          themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode;
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
                  MaterialPageRoute(builder: (context) => Dashboard()),
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
                    builder: (context) => AddEditForm(),
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
                    builder: (context) => ProfileList(),
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
            const Divider(height: 24),
            _buildThemeSwitch(context),
            ListTile(
              leading: const Icon(Icons.settings_system_daydream,
                  color: Colors.grey),
              title: const Text(
                'Use System Theme',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                themeNotifier.resetToSystemTheme();
              },
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade400,
                      Colors.red.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.shade200,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      // Add ripple effect duration
                      await Future.delayed(const Duration(milliseconds: 300));
                      if (!context.mounted) return;

                      // Show confirmation dialog
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Logout'),
                          content:
                              const Text('Are you sure you want to logout?'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text(
                                'Logout',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (shouldLogout == true && context.mounted) {
                        await SharedPrefs.setLoggedIn(false);
                        await NavigationService.navigateWithFade(
                          const MyLogin(),
                          replace: true,
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context); // Close the drawer
          onTap(); // Call the provided callback
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeSwitch(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    ThemeMode themeMode = themeNotifier.currentThemeMode;

    return ListTile(
      leading: Icon(
        themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        themeMode == ThemeMode.dark ? 'Dark Mode' : 'Light Mode',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      trailing: Switch(
        value: themeMode == ThemeMode.dark,
        onChanged: (value) {
          themeNotifier.toggleTheme();
        },
      ),
    );
  }
}
