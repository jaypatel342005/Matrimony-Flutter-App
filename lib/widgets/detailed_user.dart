import 'package:flutter/material.dart';
import 'export.dart';
import 'package:intl/intl.dart';

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

    // Format the date of birth
    String formattedDob;
    try {
      DateTime dob = DateFormat('dd/MM/yyyy').parse(user['dob']);
      formattedDob = DateFormat('dd/MM/yyyy').format(dob);
    } catch (e) {
      formattedDob = 'Invalid date';
    }

    // A helper function to build rows for key-value pairs with icons
    Widget buildKeyValueRow(IconData icon, String key, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: Colors.blue),
            const SizedBox(width: 10),
            Expanded( 
              flex: 1,
              child: Text(
                key,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const Text(
              ':',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
    }
    // Text("${user['firstName']} ${user['lastName']}")
    return Scaffold(
      appBar: CustomAppBar(title: "${user['firstName']} ${user['lastName']}",),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile image displayed with a CircleAvatar
              CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage('assets/images/default_avatar.png'),
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

              // User Information Card
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
                      buildKeyValueRow(Icons.person, "Gender", user['gender'] == 0 ? 'Female' : user['gender'] == 1 ? 'Male' : 'Other' ),
                      buildKeyValueRow(Icons.calendar_today, "Date of Birth", formattedDob),
                      buildKeyValueRow(Icons.date_range, "Age", user['age'].toString()),
                      buildKeyValueRow(Icons.star, "Religion", user['religion']),
                      buildKeyValueRow(Icons.people, "Caste", user['caste']),
                      buildKeyValueRow(Icons.people_outline, "Sub-Caste", user['subCaste']),
                      buildKeyValueRow(Icons.favorite_border, "Hobbies", user['hobbies'].join(', ')),
                      buildKeyValueRow(Icons.school, "Higher Education", user['higherEducation']),
                      buildKeyValueRow(Icons.work, "Occupation", user['occupation']),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Address Card
              const Text(
                "Address",
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
                      buildKeyValueRow(Icons.location_city, "City", user['city']),
                      buildKeyValueRow(Icons.map, "State", user['state']),
                      buildKeyValueRow(Icons.language, "Country", user['country']),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Contact Details Card
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
                      buildKeyValueRow(Icons.email, "Email ID", user['email']),
                      buildKeyValueRow(Icons.phone, "Phone", user['number']),
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
                          builder: (context) => AddEditForm(userData: user, index: widget.index),
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
                      shape: CircleBorder(), backgroundColor: Colors.blueAccent, // Circular shape
                      padding: const EdgeInsets.all(16), // Background color
                      elevation: 6, // Elevated effect
                    ),
                    child: const Icon(Icons.edit, color: Colors.white), // Edit icon only
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
                      shape: CircleBorder(), backgroundColor: Colors.redAccent, // Circular shape
                      padding: const EdgeInsets.all(16), // Background color
                      elevation: 6, // Elevated effect
                    ),
                    child: const Icon(Icons.delete, color: Colors.white), // Delete icon only
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
                      shape: CircleBorder(), backgroundColor: user['isLiked'] ? Colors.pink : Colors.grey, // Circular shape
                      padding: const EdgeInsets.all(16), // Background color
                      elevation: 6, // Elevated effect
                    ),
                    child: Icon(
                      Icons.favorite_rounded,
                      color: Colors.white, // Icon color
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