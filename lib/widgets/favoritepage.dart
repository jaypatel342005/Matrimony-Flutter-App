import 'package:flutter/material.dart';
import 'export.dart';
import 'detailed_user.dart';

final User myUser = User.instance;
dynamic users = myUser.getUserList();
dynamic likedUsers = [];

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  TextEditingController searchController = TextEditingController();
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
    users = myUser.getUserList();
    likedUsers = users.where((user) => user['isLiked'] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    likedUsers = users.where((user) => user['isLiked'] == true).toList();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Favorites',
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search favorite users...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.cancel_outlined),
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            users = myUser.getUserList();
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  users = myUser.searchDetail(searchData: value);
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: likedUsers.isEmpty
                ? Center(
                    child: Text(
                      searchController.text.isNotEmpty && users.isEmpty
                          ? "Users not found!"
                          : users.isEmpty
                              ? "No users added yet!"
                              : "No favorite users yet!",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: likedUsers.length,
                    itemBuilder: (context, index) {
                      final user = likedUsers[index];
                      final gradientIndex = index % cardGradients.length;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailedUser(index: index),
                              ),
                            );
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
                                          fontSize: 24, color: Colors.white),
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
                                              color: Colors.white),
                                        ),
                                        Text("Email: ${user['email']}",
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.white70)),
                                        Text("City: ${user['city']}",
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.white70)),
                                        Text("Mobile: ${user['number']}",
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.white70)),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite_rounded,
                                      color: user['isLiked']
                                          ? Colors.pinkAccent
                                          : Colors.white70,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        user['isLiked'] = !user['isLiked'];
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('User unliked successfully'),
                                          duration: Duration(milliseconds: 500),
                                        ),
                                      );
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
