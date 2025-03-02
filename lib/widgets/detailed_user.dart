import 'export.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

final User myUser = User.instance;

class DetailedUser extends StatefulWidget {
  final int index;
  const DetailedUser({super.key, required this.index});

  @override
  State<DetailedUser> createState() => _DetailedUserState();
}

class _DetailedUserState extends State<DetailedUser> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final users = await myUser.getUserList();
    if (mounted) {
      setState(() {
        userData = users.firstWhere((user) => user['id'] == widget.index);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    if (isLoading) {
      return Scaffold(
        appBar: CustomAppBar(title: "Loading..."),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (userData == null) {
      return Scaffold(
        appBar: CustomAppBar(title: "Error"),
        body: const Center(
          child: Text("User not found"),
        ),
      );
    }

    // Format the date of birth
    String formattedDob;
    try {
      DateTime dob = DateFormat('dd/MM/yyyy').parse(userData!['dob']);
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

    return Scaffold(
      appBar: CustomAppBar(
        title: "${userData!['firstName']} ${userData!['lastName']}",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile image displayed with a CircleAvatar
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/default_avatar.png'),
              ),
              const SizedBox(height: 16),
              Text(
                "${userData!['firstName']} ${userData!['lastName']}",
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
                      buildKeyValueRow(Icons.person, "Gender",
                          userData!['gender'] == 0 ? 'Female' : userData!['gender'] == 1 ? 'Male' : 'Other'),
                      buildKeyValueRow(Icons.calendar_today, "Date of Birth", formattedDob),
                      buildKeyValueRow(Icons.date_range, "Age", userData!['age'].toString()),
                      buildKeyValueRow(Icons.star, "Religion", userData!['religion']),
                      buildKeyValueRow(Icons.people, "Caste", userData!['caste']),
                      buildKeyValueRow(Icons.people_outline, "Sub-Caste", userData!['subCaste']),
                      buildKeyValueRow(Icons.favorite_border, "Hobbies", 
                          (userData!['hobbies'] is List 
                              ? (userData!['hobbies'] as List).join(', ')
                              : userData!['hobbies'].toString())),
                      buildKeyValueRow(Icons.school, "Higher Education", userData!['higherEducation']),
                      buildKeyValueRow(Icons.work, "Occupation", userData!['occupation']),
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
                      buildKeyValueRow(Icons.location_city, "City", userData!['city']),
                      buildKeyValueRow(Icons.map, "State", userData!['state']),
                      buildKeyValueRow(Icons.language, "Country", userData!['country']),
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
                      buildKeyValueRow(Icons.email, "Email ID", userData!['email']),
                      buildKeyValueRow(Icons.phone, "Phone", userData!['number']),
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
                          builder: (context) => AddEditForm(
                            userData: userData!,
                            index: widget.index,
                          ),
                        ),
                      );
                      if (result == true) {
                        _loadUserData(); // Reload user data after edit
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.all(16),
                      elevation: 6,
                    ),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                  // Delete Button
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text('Delete User'),
                          content: const Text('Are you sure you want to delete this user? This action cannot be undone.'),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () async {
                                await myUser.deleteUser(userData!['id']);
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('User deleted successfully'),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                  Navigator.pop(context); // Close dialog
                                  Navigator.pop(context); // Go back to previous screen
                                }
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.all(16),
                      elevation: 6,
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  // Like/Unlike Button
                  ElevatedButton(
                    onPressed: () async {
                      if (!mounted) return;
                      
                      try {
                        int newValue = userData!['isLiked'] == 0 ? 1 : 0;
                        await myUser.updateUserLikeStatus(userData!['id'], newValue);
                        
                        setState(() {
                          userData!['isLiked'] = newValue;
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
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: userData!['isLiked'] == 1 ? Colors.pink : Colors.grey,
                      padding: const EdgeInsets.all(16),
                      elevation: 6,
                    ),
                    child: Icon(
                      Icons.favorite_rounded,
                      color: Colors.white,
                      size: 24,
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