import 'package:sqflite/sqflite.dart';
import '../helpers/database_helper.dart';

class User {
  static final User instance = User._privateConstructor();
  
  User._privateConstructor() {
    _initializeDefaultUsers();
  }

  // Constants for validation
  static const int minPasswordLength = 8;
  static const int minAge = 18;
  static const int maxAge = 80;

  // Validation methods
  String? validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < minPasswordLength) {
      return 'Password must be at least $minPasswordLength characters';
    }
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$')
        .hasMatch(password)) {
      return 'Password must contain uppercase, lowercase, number and special character';
    }
    return null;
  }

  String? validateAge(int age) {
    if (age < minAge || age > maxAge) {
      return 'Age must be between $minAge and $maxAge';
    }
    return null;
  }

  Future<void> _initializeDefaultUsers() async {
    final List<Map<String, dynamic>> users = await getUserList();
    if (users.isEmpty) {
      // Add all your default users here
      await addUserInList(
        firstName: 'Jay',
        lastName: 'Patel',
        email: 'jay123@gmail.com',
        number: '9879634566',
        dob: '03/04/2005',
        city: 'Morbi',
        gender: 1,
        hobbies: ['Gaming', 'Traveling'],
        password: 'Password@123',
        confirmPassword: 'Password@123',
        country: 'India',
        state: 'Gujarat',
        religion: 'Hindu',
        caste: 'General',
        subCaste: 'Patel',
        higherEducation: 'B.Tech',
        occupation: 'Engineer',
      );
      addUserInList(
        firstName: 'Rahul',
        lastName: 'Yadav',
        email: 'rahul.yadav@gmail.com',
        number: '7210987654',
        dob: '18/12/1994',
        city: 'Patna',
        gender: 1,
        hobbies: ['Reading', 'Traveling'],
        password: 'Rahul@Bihar',
        confirmPassword: 'Rahul@Bihar',
        country: 'India',
        state: 'Bihar',
        religion: 'Hindu',
        caste: 'Yadav',
        subCaste: 'Ahir',
        higherEducation: 'B.A',
        occupation: 'Civil Servant',
      );

      addUserInList(
        firstName: 'Jinal',
        lastName: 'Patel',
        email: 'jinal.patel@gmail.com',
        number: '7109876543',
        dob: '14/08/1997',
        city: 'Mehsana',
        gender: 1,
        hobbies: ['Traveling', 'Cooking'],
        password: 'Jinal@Mehsana',
        confirmPassword: 'Jinal@Mehsana',
        country: 'India',
        state: 'Gujarat',
        religion: 'Hindu',
        caste: 'Patel',
        subCaste: 'Kadva Patel',
        higherEducation: 'B.Sc',
        occupation: 'Nutritionist',
      );

      addUserInList(
        firstName: 'Harsh',
        lastName: 'Patel',
        email: 'harsh.patel@gmail.com',
        number: '9876543120',
        dob: '10/06/1991',
        city: 'Ahmedabad',
        gender: 1,
        hobbies: ['Reading', 'Traveling'],
        password: 'Harsh@123',
        confirmPassword: 'Harsh@123',
        country: 'India',
        state: 'Gujarat',
        religion: 'Hindu',
        caste: 'Patel',
        subCaste: 'Leuva Patel',
        higherEducation: 'M.Sc',
        occupation: 'Data Scientist',
      );

      addUserInList(
        firstName: 'Amit',
        lastName: 'Patel',
        email: 'amit.patel@gmail.com',
        number: '7654321980',
        dob: '25/09/1989',
        city: 'Vadodara',
        gender: 1,
        hobbies: ['Gaming', 'Traveling'],
        password: 'Amit@Secure',
        confirmPassword: 'Amit@Secure',
        country: 'India',
        state: 'Gujarat',
        religion: 'Hindu',
        caste: 'Patel',
        subCaste: 'Leuva Patel',
        higherEducation: 'MBA',
        occupation: 'Business Analyst',
      );

      addUserInList(
        firstName: 'Aarav',
        lastName: 'Sharma',
        email: 'aarav.sharma@gmail.com',
        number: '9876543210',
        dob: '15/05/1992',
        city: 'Jaipur',
        gender: 1,
        hobbies: ['Reading', 'Traveling'],
        password: 'securePass@123',
        confirmPassword: 'securePass@123',
        country: 'India',
        state: 'Rajasthan',
        religion: 'Hindu',
        caste: 'Rajput',
        subCaste: 'Shekhawat',
        higherEducation: 'M.Tech',
        occupation: 'Software Developer',
      );

      addUserInList(
        firstName: 'Sanya',
        lastName: 'Verma',
        email: 'sanya.verma@gmail.com',
        number: '8765432109',
        dob: '20/08/1995',
        city: 'Lucknow',
        gender: 0,
        hobbies: ['Cooking', 'Reading'],
        password: 'Sanya@2023',
        confirmPassword: 'Sanya@2023',
        country: 'India',
        state: 'Uttar Pradesh',
        religion: 'Hindu',
        caste: 'Brahmin',
        subCaste: 'Sharma',
        higherEducation: 'MBA',
        occupation: 'Marketing Manager',
      );

      addUserInList(
        firstName: 'Rohan',
        lastName: 'Das',
        email: 'rohan.das@gmail.com',
        number: '7654321098',
        dob: '12/11/1988',
        city: 'Kolkata',
        gender: 1,
        hobbies: ['Gaming', 'Reading'],
        password: 'Rohan@321',
        confirmPassword: 'Rohan@321',
        country: 'India',
        state: 'West Bengal',
        religion: 'Hindu',
        caste: 'Kayastha',
        subCaste: 'Basu',
        higherEducation: 'PhD',
        occupation: 'Professor',
      );

      addUserInList(
        firstName: 'Fatima',
        lastName: 'Khan',
        email: 'fatima.khan@gmail.com',
        number: '7543210987',
        dob: '10/03/1993',
        city: 'Hyderabad',
        gender: 0,
        hobbies: ['Cooking', 'Traveling'],
        password: 'Fatima@786',
        confirmPassword: 'Fatima@786',
        country: 'India',
        state: 'Telangana',
        religion: 'Muslim',
        caste: 'Sunni',
        subCaste: 'Ansari',
        higherEducation: 'B.Sc',
        occupation: 'Nutritionist',
      );

      addUserInList(
        firstName: 'Kabir',
        lastName: 'Singh',
        email: 'kabir.singh@gmail.com',
        number: '7432109876',
        dob: '25/07/1991',
        city: 'Amritsar',
        gender: 1,
        hobbies: ['Gaming', 'Reading'],
        password: 'Kabir@Singh',
        confirmPassword: 'Kabir@Singh',
        country: 'India',
        state: 'Punjab',
        religion: 'Sikh',
        caste: 'Jat',
        subCaste: 'Gill',
        higherEducation: 'MBBS',
        occupation: 'Doctor',
      );

      addUserInList(
        firstName: 'Neha',
        lastName: 'Iyer',
        email: 'neha.iyer@gmail.com',
        number: '7321098765',
        dob: '05/09/1996',
        city: 'Bangalore',
        gender: 0,
        hobbies: ['Reading', 'Cooking'],
        password: 'Neha@Secure',
        confirmPassword: 'Neha@Secure',
        country: 'India',
        state: 'Karnataka',
        religion: 'Hindu',
        caste: 'Brahmin',
        subCaste: 'Iyer',
        higherEducation: 'B.Com',
        occupation: 'Chartered Accountant',
      );


      addUserInList(
        firstName: 'Priya',
        lastName: 'Deshmukh',
        email: 'priya.deshmukh@gmail.com',
        number: '7109876543',
        dob: '30/04/1997',
        city: 'Mumbai',
        gender: 0,
        hobbies: ['Reading', 'Traveling'],
        password: 'Priya@Mumbai',
        confirmPassword: 'Priya@Mumbai',
        country: 'India',
        state: 'Maharashtra',
        religion: 'Hindu',
        caste: 'Maratha',
        subCaste: 'Deshmukh',
        higherEducation: 'LLB',
        occupation: 'Lawyer',
      );

      addUserInList(
        firstName: 'Krishna',
        lastName: 'Patel',
        email: 'krishna.patel@gmail.com',
        number: '8765432190',
        dob: '15/02/1993',
        city: 'Surat',
        gender: 0,
        hobbies: ['Cooking', 'Reading'],
        password: 'Krishna@Patel',
        confirmPassword: 'Krishna@Patel',
        country: 'India',
        state: 'Gujarat',
        religion: 'Hindu',
        caste: 'Patel',
        subCaste: 'Kadva Patel',
        higherEducation: 'B.Tech',
        occupation: 'Software Engineer',
      );

      addUserInList(
        firstName: 'Pooja',
        lastName: 'Patel',
        email: 'pooja.patel@gmail.com',
        number: '7543219870',
        dob: '05/12/1994',
        city: 'Rajkot',
        gender: 0,
        hobbies: ['Cooking', 'Traveling'],
        password: 'Pooja@Rajkot',
        confirmPassword: 'Pooja@Rajkot',
        country: 'India',
        state: 'Gujarat',
        religion: 'Hindu',
        caste: 'Patel',
        subCaste: 'Kadva Patel',
        higherEducation: 'B.Com',
        occupation: 'Accountant',
      );

      addUserInList(
        firstName: 'Dev',
        lastName: 'Patel',
        email: 'dev.patel@gmail.com',
        number: '7432198760',
        dob: '18/07/1995',
        city: 'Gandhinagar',
        gender: 1,
        hobbies: ['Reading', 'Gaming'],
        password: 'Dev@Gujarat',
        confirmPassword: 'Dev@Gujarat',
        country: 'India',
        state: 'Gujarat',
        religion: 'Hindu',
        caste: 'Patel',
        subCaste: 'Leuva Patel',
        higherEducation: 'MCA',
        occupation: 'IT Consultant',
      );

      addUserInList(
        firstName: 'Ritika',
        lastName: 'Patel',
        email: 'ritika.patel@gmail.com',
        number: '7321987650',
        dob: '22/04/1996',
        city: 'Bhavnagar',
        gender: 0,
        hobbies: ['Reading', 'Traveling'],
        password: 'Ritika@Secure',
        confirmPassword: 'Ritika@Secure',
        country: 'India',
        state: 'Gujarat',
        religion: 'Hindu',
        caste: 'Patel',
        subCaste: 'Kadva Patel',
        higherEducation: 'LLB',
        occupation: 'Lawyer',
      );

      addUserInList(
        firstName: 'Sanya',
        lastName: 'Verma',
        email: 'sanya.verma@gmail.com',
        number: '8765432109',
        dob: '20/08/1995',
        city: 'Lucknow',
        gender: 0,
        hobbies: ['Cooking', 'Reading'],
        password: 'Sanya@2023',
        confirmPassword: 'Sanya@2023',
        country: 'India',
        state: 'Uttar Pradesh',
        religion: 'Hindu',
        caste: 'Brahmin',
        subCaste: 'Sharma',
        higherEducation: 'MBA',
        occupation: 'Marketing Manager',
      );

      addUserInList(
        firstName: 'Dev',
        lastName: 'Patel',
        email: 'dev.patel@gmail.com',
        number: '7432198760',
        dob: '18/07/1995',
        city: 'Gandhinagar',
        gender: 1,
        hobbies: ['Reading', 'Gaming'],
        password: 'Dev@Gujarat',
        confirmPassword: 'Dev@Gujarat',
        country: 'India',
        state: 'Gujarat',
        religion: 'Hindu',
        caste: 'Patel',
        subCaste: 'Leuva Patel',
        higherEducation: 'MCA',
        occupation: 'IT Consultant',
      );

      addUserInList(
        firstName: 'Neha',
        lastName: 'Iyer',
        email: 'neha.iyer@gmail.com',
        number: '7321098765',
        dob: '05/09/2000',
        city: 'Bangalore',
        gender: 0,
        hobbies: ['Cooking', 'Reading'],
        password: 'Neha@Secure',
        confirmPassword: 'Neha@Secure',
        country: 'India',
        state: 'Karnataka',
        religion: 'Hindu',
        caste: 'Brahmin',
        subCaste: 'Iyer',
        higherEducation: 'B.Com',
        occupation: 'Chartered Accountant',
      );

      addUserInList(
        firstName: 'Rohan',
        lastName: 'Das',
        email: 'rohan.das@gmail.com',
        number: '7654321098',
        dob: '12/11/2003',
        city: 'Kolkata',
        gender: 1,
        hobbies: ['Gaming', 'Traveling'],
        password: 'Rohan@321',
        confirmPassword: 'Rohan@321',
        country: 'India',
        state: 'West Bengal',
        religion: 'Christian',
        caste: 'N/A',
        subCaste: 'N/A',
        higherEducation: 'PhD',
        occupation: 'Professor',
      );
    }
  }

  Future<void> addUserInList({
    required String firstName,
    required String lastName,
    required String email,
    required String number,
    required String dob,
    required String city,
    required int gender,
    required List<String> hobbies,
    required String password,
    required String confirmPassword,
    required String country,
    required String state,
    required String religion,
    required String caste,
    required String subCaste,
    required String higherEducation,
    required String occupation,
  }) async {
    final db = await DatabaseHelper.instance.database;
    
    await db.insert(
      'users',
      {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'number': number,
        'dob': dob,
        'age': calculateAge(dob),
        'city': city,
        'gender': gender,
        'hobbies': hobbies.join(','),
        'password': password,
        'confirmPassword': confirmPassword,
        'country': country,
        'state': state,
        'religion': religion,
        'caste': caste,
        'subCaste': subCaste,
        'higherEducation': higherEducation,
        'occupation': occupation,
        'isLiked': 0,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getUserList() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final List<Map<String, dynamic>> maps = await db.query('users');
      
      return maps.map((map) {
        return {
          ...map,
          'hobbies': (map['hobbies'] as String).split(','),
          'isLiked': map['isLiked'],  // Keep as integer (0 or 1)
        };
      }).toList();
    } catch (e) {
      print('Error getting user list: $e');
      rethrow;
    }
  }

  Future<void> updateUser({
    required String firstName,
    required String lastName,
    required String email,
    required String number,
    required String dob,
    required String city,
    required int gender,
    required List<String> hobbies,
    required String password,
    required String confirmPassword,
    required int id,
    required String country,
    required String state,
    required String religion,
    required String caste,
    required String subCaste,
    required String higherEducation,
    required String occupation,
    bool? isLiked,
  }) async {
    final db = await DatabaseHelper.instance.database;
    
    final Map<String, dynamic> updateData = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'number': number,
      'dob': dob,
      'age': calculateAge(dob),
      'city': city,
      'gender': gender,
      'hobbies': hobbies.join(','),
      'password': password,
      'confirmPassword': confirmPassword,
      'country': country,
      'state': state,
      'religion': religion,
      'caste': caste,
      'subCaste': subCaste,
      'higherEducation': higherEducation,
      'occupation': occupation,
    };

    if (isLiked != null) {
      updateData['isLiked'] = isLiked ? 1 : 0;
    }
    
    try {
      await db.update(
        'users',
        updateData,
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  Future<void> deleteUser(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> searchDetail({required String searchData}) async {
    if (searchData.isEmpty) return [];
    
    try {
      final db = await DatabaseHelper.instance.database;
      final searchTerm = '%${searchData.toLowerCase()}%';
      
      // Enhanced search query with better matching and ordering
      final List<Map<String, dynamic>> results = await db.rawQuery('''
        SELECT *, 
          CASE 
            WHEN LOWER(firstName || ' ' || lastName) = ? THEN 0
            WHEN LOWER(firstName || ' ' || lastName) LIKE ? THEN 1
            WHEN LOWER(firstName) LIKE ? THEN 2
            WHEN LOWER(lastName) LIKE ? THEN 3
            WHEN LOWER(city) LIKE ? THEN 4
            WHEN LOWER(number) LIKE ? THEN 5
            WHEN LOWER(email) LIKE ? THEN 6
            WHEN LOWER(religion) LIKE ? THEN 7
            WHEN LOWER(occupation) LIKE ? THEN 8
            WHEN LOWER(CAST(age as TEXT)) LIKE ? THEN 9
            ELSE 10
          END as search_rank
        FROM users 
        WHERE 
          LOWER(firstName || ' ' || lastName) LIKE ? 
          OR LOWER(firstName) LIKE ?
          OR LOWER(lastName) LIKE ?
          OR LOWER(city) LIKE ? 
          OR LOWER(number) LIKE ?
          OR LOWER(email) LIKE ?
          OR LOWER(religion) LIKE ?
          OR LOWER(occupation) LIKE ?
          OR LOWER(CAST(age as TEXT)) LIKE ?
        ORDER BY search_rank, firstName
      ''', [
        searchData.toLowerCase(), // Exact match
        searchTerm, searchTerm, searchTerm, searchTerm, 
        searchTerm, searchTerm, searchTerm, searchTerm, 
        searchTerm, searchTerm, searchTerm, searchTerm, 
        searchTerm, searchTerm, searchTerm, searchTerm,
        searchTerm
      ]);

      return results.map((map) {
        return {
          ...map,
          'hobbies': (map['hobbies'] as String).split(','),
          'isLiked': map['isLiked'],
        };
      }).toList();
    } catch (e) {
      print('Error searching users: $e');
      rethrow;
    }
  }

  int calculateAge(String dateOfBirth) {
    DateTime birthDate = DateTime.parse(dateOfBirth.split('/').reversed.join('-'));
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<bool> isUserLiked(int id) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final List<Map<String, dynamic>> result = await db.query(
        'users',
        columns: ['isLiked'],
        where: 'id = ?',
        whereArgs: [id],
      );
      
      if (result.isEmpty) return false;
      return result.first['isLiked'] == 1;
    } catch (e) {
      print('Error checking like status: $e');
      return false;
    }
  }

  Future<bool> toggleLike(int id) async {
    try {
      final db = await DatabaseHelper.instance.database;
      
      // Get current like status
      final List<Map<String, dynamic>> result = await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
      
      if (result.isEmpty) {
        throw Exception('User not found');
      }

      // Toggle the like status
      final currentStatus = result.first['isLiked'] ?? 0;
      final newStatus = currentStatus == 1 ? 0 : 1;

      // Update the database
      await db.rawUpdate('''
        UPDATE users 
        SET isLiked = ? 
        WHERE id = ?
      ''', [newStatus, id]);

      return newStatus == 1;
    } catch (e) {
      print('Error toggling like status: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final List<Map<String, dynamic>> results = await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (results.isEmpty) {
        return null;
      }

      final map = results.first;
      final hobbies = map['hobbies'] as String;
      final isLiked = map['isLiked'] ?? 0;

      return {
        ...map,
        'hobbies': hobbies.split(','),
        'isLiked': isLiked == 1,
      };
    } catch (e) {
      print('Error getting user by ID: $e');
      rethrow;
    }
  }

  Future<void> updateUserLikeStatus(int id, int newValue) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.rawUpdate('''
        UPDATE users 
        SET isLiked = ? 
        WHERE id = ?
      ''', [newValue, id]);
    } catch (e) {
      print('Error updating like status: $e');
      rethrow;
    }
  }

  Future<void> limitDatabaseRecords(int limit) async {
    final db = await DatabaseHelper.instance.database;
    try {
      // Get total count of records
      final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM users')
      );

      if (count != null && count > limit) {
        // Delete older records keeping only the most recent 'limit' records
        await db.execute('''
          DELETE FROM users 
          WHERE id NOT IN (
            SELECT id FROM users 
            ORDER BY id DESC 
            LIMIT $limit
          )
        ''');
      }
    } catch (e) {
      print('Error limiting database records: $e');
    }
  }

  Future<bool> addUser(Map<String, dynamic> userData) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.insert('users', userData);
      
      // Keep only the most recent 10 records
      await limitDatabaseRecords(10);
      
      return true;
    } catch (e) {
      print('Error adding user: $e');
      return false;
    }
  }

  Future<void> clearDatabase() async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete('users'); // This will delete all records from the users table
      print('Database cleared successfully');
    } catch (e) {
      print('Error clearing database: $e');
    }
  }
}