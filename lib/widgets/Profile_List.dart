import 'package:flutter/cupertino.dart';
import 'detailed_user.dart';
import 'export.dart';
import 'dart:async';
import 'package:matrimony_flutter_app/services/navigation_service.dart';

final User myUser = User.instance;

class ProfileList extends StatefulWidget {
  const ProfileList({super.key});

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;
  int _gradientIndex = 0;
  Timer? _gradientTimer;
  Timer? _debounceTimer;
  String _lastSearchTerm = '';
  bool _isLoading = false;
  bool _showSearch = false;

  final List<List<Color>> cardGradients = [
    [Colors.purple.shade500, Colors.blueAccent.shade100],
    [Colors.red.shade500, Colors.orangeAccent.shade100],
    [Colors.teal.shade500, Colors.greenAccent.shade100],
    [Colors.indigo.shade500, Colors.pinkAccent.shade100],
    [Colors.cyan.shade500, Colors.yellowAccent.shade100],
    [Colors.deepPurple.shade500, Colors.lightBlueAccent.shade100],
    [Colors.amber.shade500, Colors.deepOrange.shade100],
    [Colors.blueGrey.shade500, Colors.blueAccent.shade100],
    [Colors.pink.shade500, Colors.deepPurple.shade100],
    [Colors.blue.shade500, Colors.cyan.shade100],
    [Colors.orange.shade500, Colors.red.shade100],
    [Colors.green.shade500, Colors.lightGreen.shade100],
    [Colors.cyan.shade500, Colors.teal.shade100],
  ];

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _gradientTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _gradientIndex = (_gradientIndex + 1) % cardGradients.length;
        });
      }
    });
  }

  Future<void> _loadUsers() async {
    setState(() {
      isLoading = true;
    });

    try {
      final loadedUsers = await myUser.getUserList();
      if (mounted) {
        setState(() {
          users = loadedUsers;
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
          const SnackBar(content: Text('Error loading users')),
        );
      }
    }
  }

  void _debouncedSearch(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_lastSearchTerm != value) {
        _lastSearchTerm = value;
        _performSearch(value);
      }
    });
  }

  Future<void> _performSearch(String value) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (value.isEmpty) {
        await _loadUsers();
      } else {
        final searchResults = await myUser.searchDetail(searchData: value);
        if (mounted) {
          setState(() {
            users = searchResults;
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          users = [];
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error searching users')),
        );
      }
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    _gradientTimer?.cancel();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _showDeleteConfirmationDialog(int index) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Cancel', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                await myUser.deleteUser(users[index]['id']);
                Navigator.pop(context);
                _loadUsers(); // Reload the list after deletion
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile List",
        onSearchTap: () {
          setState(() {
            _showSearch = !_showSearch;
            if (!_showSearch) {
              searchController.clear();
              _performSearch('');
            }
          });
        },
      ),
      drawer: const CustomDrawer(),
      body: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            if (_showSearch)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: SearchBar(
                  controller: searchController,
                  hintText: 'Search by name, city, age, religion...',
                  leading: const Icon(Icons.search),
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  onChanged: _debouncedSearch,
                  trailing: [
                    if (searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          _performSearch('');
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
                  ? const Center(
                child: Text(
                  "No users found!",
                  style: TextStyle(
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
                        horizontal: 12.0, vertical: 6.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (_isLoading) return;

                        setState(() => _isLoading = true);
                        try {
                          await NavigationService.navigateWithFade(
                            DetailedUser(index: user['id']),
                          );
                          await _loadUsers(); // Refresh list after returning
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Navigation error occurred'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() => _isLoading = false);
                          }
                        }
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
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                    Colors.deepOrangeAccent,
                                    child: Text(
                                      user['firstName'][0].toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.white),
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
                                              fontSize: 18,
                                              overflow:
                                              TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "${user['age']} years",
                                          style: const TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: user['isLiked'] == 1 ? Colors.pink : Colors.white70,
                                      size: 24,
                                    ),
                                    onPressed: () async {
                                      if (!mounted) return;

                                      try {
                                        int newValue = user['isLiked'] == 0 ? 1 : 0;
                                        await myUser.updateUserLikeStatus(user['id'], newValue);

                                        setState(() {
                                          user['isLiked'] = newValue;
                                        });

                                        if (mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(newValue == 1
                                                  ? 'User liked successfully'
                                                  : 'User unliked successfully'),
                                              duration: const Duration(milliseconds: 500),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        if (mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Error updating like status'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                  PopupMenuButton(
                                    icon: const Icon(Icons.more_vert,
                                        color: Colors.white),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Row(
                                          children: const [
                                            Icon(Icons.edit,
                                                color: Colors.blue),
                                            SizedBox(width: 8),
                                            Text('Edit'),
                                          ],
                                        ),
                                        onTap: () async {
                                          await Future.delayed(
                                              Duration.zero);
                                          if (mounted) {
                                            final result =
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddEditForm(
                                                      userData: user,
                                                      index: index,
                                                    ),
                                              ),
                                            );
                                            if (result == true) {
                                              _loadUsers();
                                            }
                                          }
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Row(
                                          children: const [
                                            Icon(Icons.delete,
                                                color: Colors.red),
                                            SizedBox(width: 8),
                                            Text('Delete'),
                                          ],
                                        ),
                                        onTap: () async {
                                          await Future.delayed(
                                              Duration.zero);
                                          if (mounted) {
                                            _showDeleteConfirmationDialog(
                                                index);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                  thickness: 1, color: Colors.white54),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 16,
                                      color: Colors.greenAccent),
                                  const SizedBox(width: 4),
                                  Text(user['city'],
                                      style: const TextStyle(
                                          color: Colors.white)),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.phone,
                                      size: 16,
                                      color: Colors.purpleAccent),
                                  const SizedBox(width: 4),
                                  Text(user['number'],
                                      style: const TextStyle(
                                          color: Colors.white)),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.email,
                                      size: 16,
                                      color: Colors.blueAccent),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      user['email'],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
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
      ),
    );
  }
}