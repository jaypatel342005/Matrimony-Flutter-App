import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_flutter_app/widgets/userdata.dart';

import 'Add_Profile.dart';
import 'detailed_user.dart';
import 'export.dart';

final User myUser = User.instance;
dynamic users = myUser.getUserList();

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    users = myUser.getUserList();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose the controller to avoid memory leaks
    super.dispose();
  }

  // Show Cupertino-style dialog for confirmation before deletion
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
                Navigator.pop(context); // Close the dialog
              },
            ),
            CupertinoDialogAction(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                setState(() {
                  myUser.deleteUser(index); // Delete the user
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
    final cardBackground = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[850]
        : Colors.white;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search users...',
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
              onChanged: (value) {
                setState(() {
                  users = myUser.searchDeatail(searchData: value);
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: myUser.getUserList().isEmpty
                ? const Center(
              child: Text(
                "No users added yet!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
                : searchController.text.isNotEmpty && users.isEmpty
                ? const Center(
              child: Text(
                "Users not found!",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
                : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
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
                    child: Card(
                      color: cardBackground,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Avatar on the left
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
                            // User details
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // Name with ellipsis for long text
                                  Text(
                                    "${user['firstName']} ${user['lastName']}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  // Light line (Divider)
                                  Divider(
                                    color: Colors.grey[300], // Light color for the divider line
                                    thickness: 1, // Thickness of the line
                                  ),
                                  const SizedBox(height: 8),
                                  // City
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          size: 16,
                                          color: Colors.green),
                                      const SizedBox(width: 4),
                                      Text("${user['city']}"),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  // Email
                                  Row(
                                    children: [
                                      const Icon(Icons.email,
                                          size: 16,
                                          color: Colors.blue),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          "${user['email']}",
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  // Phone
                                  Row(
                                    children: [
                                      const Icon(Icons.phone,
                                          size: 16,
                                          color: Colors.purple),
                                      const SizedBox(width: 4),
                                      Text("${user['number']}"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Icons on the right
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () async {
                                    final result =
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddUserForm(
                                                userData: user,
                                                index: index),
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
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(
                                        index);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.favorite,
                                      color: user['isLiked']
                                          ? Colors.red
                                          : Colors.grey),
                                  onPressed: () {
                                    setState(() {
                                      user['isLiked'] =
                                      !user['isLiked'];
                                    });
                                  },
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
