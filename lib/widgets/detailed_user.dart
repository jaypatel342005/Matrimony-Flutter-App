import 'package:flutter/material.dart';

import 'Add_Profile.dart';
import 'export.dart';
import 'userdata.dart';

final User myUser = User.instance;

class DetailedUser extends StatefulWidget {
  final int index;
  const DetailedUser({Key? key, required this.index}) : super(key: key);

  @override
  State<DetailedUser> createState() => _DetailedUserState();
}

class _DetailedUserState extends State<DetailedUser> {
  @override
  Widget build(BuildContext context) {
    final user = myUser.getUserList()[widget.index];
    // Ensure the image path is correct and added to pubspec.yaml
    const String imageUrl = 'assets/images/default_avatar.png';

    // A helper function to build rows for key-value pairs
    Widget buildKeyValueRow(String key, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                key,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const Text(
              ':',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${user['firstName']} ${user['lastName']}"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      // drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile image displayed with a CircleAvatar
              CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage(imageUrl),
              ),
              const SizedBox(height: 16),
              Text(
                "${user['firstName']} ${user['lastName']}",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text(
                "Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      buildKeyValueRow("Gender", user['gender'] == 0 ? 'Female' : 'Male'),
                      buildKeyValueRow("Date of Birth", user['dob']),
                      buildKeyValueRow("Age", user['age'].toString()),
                      buildKeyValueRow("City", user['city'].toString()),
                      buildKeyValueRow("Hobbies", user['hobbies'].join(', ')),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Contact Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      buildKeyValueRow("Email ID", user['email']),
                      buildKeyValueRow("Phone", user['number'].toString()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Action buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Edit Button
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddUserForm(userData: user, index: widget.index),
                        ),
                      );
                      if (result == true) {
                        setState(() {
                          // Refresh the user list if needed
                          myUser.getUserList();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.edit, color: Colors.green),
                        SizedBox(height: 8),
                        Text("Edit"),
                      ],
                    ),
                  ),
                  // Delete Button
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Are you sure you want to delete?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  myUser.deleteUser(widget.index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('User deleted successfully'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(height: 8),
                        Text("Delete"),
                      ],
                    ),
                  ),
                  // Like/Unlike Button
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        user['isLiked'] = !user['isLiked'];
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(user['isLiked']
                              ? 'User liked successfully'
                              : 'User unliked successfully'),
                          duration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          color: user['isLiked'] ? Colors.red : Colors.black54,
                        ),
                        const SizedBox(height: 8),
                        Text(user['isLiked'] ? "Unlike" : 'Like'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
