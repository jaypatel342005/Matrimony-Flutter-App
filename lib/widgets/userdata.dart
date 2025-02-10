class User {
  List<Map<String, dynamic>> userList = [];

  User._privateConstructor() {
    addUserInList(
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


  static final User instance = User._privateConstructor();

  void addUserInList({
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
  }) {
    Map<String, dynamic> map = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'number': number,
      'dob': dob,
      'age': calculateAge(dob),
      'city': city,
      'gender': gender,
      'hobbies': hobbies,
      'password': password,
      'confirmPassword': confirmPassword,
      'country': country,
      'state': state,
      'religion': religion,
      'caste': caste,
      'subCaste': subCaste,
      'higherEducation': higherEducation,
      'occupation': occupation,
      'isLiked': false,
    };
    userList.add(map);
  }

  List<Map<String, dynamic>> getUserList() {
    return userList;
  }

  void updateUser({
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
  }) {
    Map<String, dynamic> map = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'number': number,
      'dob': dob,
      'age': calculateAge(dob),
      'city': city,
      'gender': gender,
      'hobbies': hobbies,
      'password': password,
      'confirmPassword': confirmPassword,
      'country': country,
      'state': state,
      'religion': religion,
      'caste': caste,
      'subCaste': subCaste,
      'higherEducation': higherEducation,
      'occupation': occupation,
      'isLiked': userList[id]['isLiked'],
    };
    userList[id] = map;
  }

  void deleteUser(int id) {
    userList.removeAt(id);
  }

  List<Map<String, dynamic>>? searchDetail({required String searchData}) {
    List<Map<String, dynamic>> temp = [];
    for (var element in userList) {
      String name = '${element['firstName'].toString().toLowerCase()} ${element['lastName'].toString().toLowerCase()}';
      if (searchData.isNotEmpty && (name.contains(searchData.toLowerCase()) ||
          element['city'].toString().toLowerCase().contains(searchData.toLowerCase()) ||
          element['number'].toString().toLowerCase().contains(searchData.toLowerCase()) ||
          element['age'].toString().toLowerCase().contains(searchData.toLowerCase()) ||
          element['email'].toString().toLowerCase().contains(searchData.toLowerCase()))) {
        temp.add(element);
      }
    }
    return temp;
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
}