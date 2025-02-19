import 'export.dart';
import 'detailed_user.dart';

final User myUser = User.instance;

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;
  bool _showSearch = false;

  final List<List<Color>> cardGradients = [
    [Colors.purple.shade500, Colors.blueAccent.shade100],
    [Colors.red.shade500, Colors.orangeAccent.shade100],
    [Colors.teal.shade500, Colors.greenAccent.shade100],
    [Colors.indigo.shade500, Colors.pinkAccent.shade100],
    [Colors.cyan.shade500, Colors.yellowAccent.shade100],
    [Colors.deepPurple.shade500, Colors.lightBlueAccent.shade100],
  ];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      final allUsers = await myUser.getUserList();
      if (mounted) {
        setState(() {
          users = allUsers.where((user) => user['isLiked'] == 1).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          users = [];
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error loading favorites')),
        );
      }
    }
  }

  Future<void> _handleSearch(String value) async {
    if (value.isEmpty) {
      _loadUsers();
      return;
    }

    try {
      final searchResults = await myUser.searchDetail(searchData: value);
      if (mounted) {
        setState(() {
          users = searchResults.where((user) => user['isLiked'] == 1).toList();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error searching users')),
        );
      }
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favorites',
        onSearchTap: () {
          setState(() {
            _showSearch = !_showSearch;
            if (!_showSearch) {
              searchController.clear();
              _loadUsers();
            }
          });
        },
      ),
      body: Column(
        children: [
          if (_showSearch)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SearchBar(
                controller: searchController,
                hintText: 'Search favorite users...',
                leading: const Icon(Icons.search),
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onChanged: _handleSearch,
                trailing: [
                  if (searchController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        _loadUsers();
                      },
                    ),
                ],
              ),
            ),
          if (_showSearch) const SizedBox(height: 4),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : users.isEmpty
                    ? Center(
                        child: Text(
                          "No favorite users yet!",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          final gradientIndex = index % cardGradients.length;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailedUser(index: user['id']),
                                  ),
                                ).then((_) => _loadUsers());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: cardGradients[gradientIndex],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: cardGradients[gradientIndex][0]
                                          .withOpacity(0.5),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                    BoxShadow(
                                      color: cardGradients[gradientIndex][1]
                                          .withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(-4, -4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.deepOrangeAccent,
                                        child: Text(
                                          user['firstName'][0].toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${user['firstName']} ${user['lastName']}",
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "Email: ${user['email']}",
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            Text(
                                              "City: ${user['city']}",
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            Text(
                                              "Mobile: ${user['number']}",
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.favorite_rounded,
                                          color: Colors.pink,
                                          size: 24,
                                        ),
                                        onPressed: () async {
                                          if (!mounted) return;
                                          
                                          try {
                                            await myUser.updateUserLikeStatus(user['id'], 0);
                                            await _loadUsers(); // Reload the list to update UI
                                            
                                            if (mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Removed from favorites'),
                                                  duration:
                                                      Duration(milliseconds: 500),
                                                ),
                                              );
                                            }
                                          } catch (e) {
                                            if (mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Error updating favorites'),
                                                  duration: Duration(seconds: 2),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
