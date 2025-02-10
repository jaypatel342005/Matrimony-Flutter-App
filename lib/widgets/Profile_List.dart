import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_flutter_app/widgets/userdata.dart';
import 'detailed_user.dart';
import 'export.dart';
import 'dart:async';

final User myUser = User.instance;

class ProfileList extends StatefulWidget {
  const ProfileList({Key? key}) : super(key: key);

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  final TextEditingController searchController = TextEditingController();
  dynamic users = [];
  int _gradientIndex = 0;
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



  void initState() {
    super.initState();
    users = myUser.getUserList();
    searchController.addListener(() {
      setState(() {
        users = myUser.searchDetail(searchData: searchController.text);
      });
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _gradientIndex = (_gradientIndex + 1) % cardGradients.length;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _showDeleteConfirmationDialog(int filteredIndex) async {
    final originalIndex = myUser.getUserList().indexOf(users[filteredIndex]);

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child:
              const Text('Cancel', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
            CupertinoDialogAction(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                setState(() {
                  myUser.deleteUser(originalIndex); // Delete the user
                  users = myUser.getUserList(); // Update the user list
                });
                Navigator.pop(context); // Close the dialog
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
      appBar: const CustomAppBar(title: "Profile List",),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search people & places...',
                prefixIcon: const Icon(Icons.search),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
            ),
          ),
          const SizedBox(height: 0),
          Expanded(
            child: users.isEmpty
                ? const Center(
              child: Text(
                "No users added yet!",
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
                : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, filteredIndex) {
                final user = users[filteredIndex];
                final gradientIndex = filteredIndex % cardGradients.length;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedUser(
                              index: myUser.getUserList().indexOf(user)),
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
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Avatar
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
                                // User name and age
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${user['firstName']} ${user['lastName']}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            overflow: TextOverflow.ellipsis,
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
                                // Favorite icon
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: user['isLiked']
                                        ? Colors.pinkAccent
                                        : Colors.white70,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      user['isLiked'] = !user['isLiked'];
                                    });
                                  },
                                ),
                                // Three-dot menu
                                PopupMenuButton(
                                  icon: const Icon(Icons.more_vert,
                                      color: Colors.white),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit,
                                              color: Colors.blue),
                                          const SizedBox(width: 8),
                                          const Text('Edit'),
                                        ],
                                      ),
                                      onTap: () async {
                                        final result =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddEditForm(
                                                  userData: user,
                                                  index: myUser
                                                      .getUserList()
                                                      .indexOf(user),
                                                ),
                                          ),
                                        );
                                        if (result == true) {
                                          setState(() {
                                            users =
                                                myUser.getUserList();
                                          });
                                        }
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete,
                                              color: Colors.red),
                                          const SizedBox(width: 8),
                                          const Text('Delete'),
                                        ],
                                      ),
                                      onTap: () {
                                        _showDeleteConfirmationDialog(
                                            filteredIndex);
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
                                    size: 16, color: Colors.greenAccent),
                                const SizedBox(width: 4),
                                Text("${user['city']}",
                                    style: const TextStyle(
                                        color: Colors.white)),
                                const SizedBox(width: 16),
                                const Icon(Icons.phone,
                                    size: 16,
                                    color: Colors.purpleAccent),
                                const SizedBox(width: 4),
                                Text("${user['number']}",
                                    style: const TextStyle(
                                        color: Colors.white)),
                                const SizedBox(width: 16),
                                const Icon(Icons.email,
                                    size: 16,
                                    color: Colors.blueAccent),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    "${user['email']}",
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
    );
  }
}
