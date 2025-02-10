import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'export.dart';

class AddEditForm extends StatefulWidget {
  final Map<String, dynamic>? userData;
  final int? index;

  const AddEditForm({Key? key, this.userData, this.index}) : super(key: key);

  @override
  State<AddEditForm> createState() => _AddEditFormState();
}

class _AddEditFormState extends State<AddEditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController casteController = TextEditingController();
  final TextEditingController subCasteController = TextEditingController();
  final TextEditingController higherEducationController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();

  String selectedState = 'Gujarat';
  String selectedCity = 'Ahmedabad';
  String selectedReligion = 'Hindu';

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Delhi'
  ];

  Map<String, List<String>> stateCityMap = {
    'Andhra Pradesh': ['Visakhapatnam', 'Vijayawada', 'Tirupati', 'Guntur', 'Nellore', 'Kurnool', 'Rajahmundry', 'Kadapa', 'Anantapur', 'Eluru', 'Ongole', 'Machilipatnam', 'Chittoor', 'Srikakulam', 'Vizianagaram'],
    'Arunachal Pradesh': ['Itanagar', 'Naharlagun', 'Pasighat', 'Tawang', 'Ziro', 'Roing', 'Bomdila'],
    'Assam': ['Guwahati', 'Silchar', 'Dibrugarh', 'Tezpur', 'Nagaon', 'Jorhat', 'Tinsukia', 'Bongaigaon', 'Dhubri', 'Diphu', 'Goalpara', 'Hailakandi'],
    'Bihar': ['Patna', 'Gaya', 'Bhagalpur', 'Muzaffarpur', 'Darbhanga', 'Purnia', 'Arrah', 'Begusarai', 'Munger', 'Chhapra', 'Katihar', 'Motihari', 'Samastipur', 'Sasaram', 'Siwan'],
    'Chhattisgarh': ['Raipur', 'Bilaspur', 'Durg', 'Korba', 'Jagdalpur', 'Raigarh', 'Ambikapur', 'Rajnandgaon', 'Mahasamund'],
    'Goa': ['Panaji', 'Margao', 'Mapusa', 'Ponda', 'Vasco da Gama'],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Bhavnagar', 'Jamnagar', 'Junagadh', 'Gandhinagar', 'Anand', 'Surendranagar', 'Navsari', 'Mehsana', 'Morbi'],
    'Haryana': ['Chandigarh', 'Gurugram', 'Faridabad', 'Ambala', 'Hisar', 'Panipat', 'Rohtak', 'Karnal', 'Yamunanagar', 'Sonipat', 'Sirsa', 'Bhiwani', 'Panchkula'],
    'Himachal Pradesh': ['Shimla', 'Dharamshala', 'Solan', 'Mandi', 'Kullu', 'Bilaspur', 'Hamirpur', 'Chamba', 'Una', 'Palampur'],
    'Jharkhand': ['Ranchi', 'Jamshedpur', 'Dhanbad', 'Bokaro', 'Deoghar', 'Hazaribagh', 'Giridih', 'Ramgarh', 'Dumka', 'Chaibasa', 'Medininagar'],
    'Karnataka': ['Bangalore', 'Mysore', 'Mangalore', 'Hubli', 'Belgaum', 'Davanagere', 'Shivamogga', 'Tumkur', 'Udupi', 'Gulbarga', 'Bellary', 'Bidar'],
    'Kerala': ['Thiruvananthapuram', 'Kochi', 'Kozhikode', 'Kollam', 'Thrissur', 'Alappuzha', 'Palakkad', 'Malappuram', 'Kannur', 'Kasaragod', 'Idukki'],
    'Madhya Pradesh': ['Bhopal', 'Indore', 'Gwalior', 'Jabalpur', 'Ujjain', 'Sagar', 'Ratlam', 'Satna', 'Rewa', 'Dewas', 'Chhindwara'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Aurangabad', 'Thane', 'Solapur', 'Kolhapur', 'Amravati', 'Akola', 'Jalgaon', 'Latur', 'Nanded', 'Dhule'],
    'Manipur': ['Imphal', 'Thoubal', 'Bishnupur', 'Churachandpur'],
    'Meghalaya': ['Shillong', 'Tura', 'Jowai', 'Nongpoh'],
    'Mizoram': ['Aizawl', 'Lunglei', 'Champhai', 'Serchhip'],
    'Nagaland': ['Kohima', 'Dimapur', 'Mokokchung', 'Wokha'],
    'Odisha': ['Bhubaneswar', 'Cuttack', 'Berhampur', 'Rourkela', 'Sambalpur', 'Balasore', 'Puri', 'Bhadrak', 'Jajpur', 'Baripada'],
    'Punjab': ['Chandigarh', 'Amritsar', 'Ludhiana', 'Jalandhar', 'Patiala', 'Bathinda', 'Mohali', 'Hoshiarpur', 'Pathankot'],
    'Rajasthan': ['Jaipur', 'Udaipur', 'Jodhpur', 'Ajmer', 'Bikaner', 'Kota', 'Alwar', 'Bhilwara', 'Sikar', 'Sri Ganganagar'],
    'Sikkim': ['Gangtok', 'Namchi', 'Gyalshing'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai', 'Tiruchirappalli', 'Salem', 'Erode', 'Tirunelveli', 'Vellore', 'Thoothukudi'],
    'Telangana': ['Hyderabad', 'Warangal', 'Nizamabad', 'Karimnagar', 'Khammam', 'Ramagundam', 'Mahbubnagar'],
    'Tripura': ['Agartala', 'Belonia', 'Dharmanagar', 'Udaipur'],
    'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Varanasi', 'Agra', 'Ghaziabad', 'Meerut', 'Allahabad', 'Bareilly', 'Moradabad', 'Aligarh', 'Saharanpur', 'Gorakhpur'],
    'Uttarakhand': ['Dehradun', 'Haridwar', 'Rudrapur', 'Haldwani', 'Roorkee', 'Nainital'],
    'West Bengal': ['Kolkata', 'Siliguri', 'Durgapur', 'Asansol', 'Howrah', 'Kharagpur', 'Malda', 'Bardhaman'],
    'Delhi': ['New Delhi', 'Delhi'],
  };

  List<String> religions = ['Hindu', 'Muslim', 'Christian', 'Sikh', 'Other'];

  int? selectedGender;
  List<String> selectedHobbies = [];
  final Map<String, bool> hobbies = {
    'Reading': false,
    'Traveling': false,
    'Gaming': false,
    'Cooking': false,
  };

  @override
  void initState() {
    super.initState();
    if (widget.userData != null) {
      firstNameController.text = widget.userData!['firstName'] ?? '';
      lastNameController.text = widget.userData!['lastName'] ?? '';
      emailController.text = widget.userData!['email'] ?? '';
      mobileController.text = widget.userData!['number'] ?? '';
      dobController.text = widget.userData!['dob'] ?? '';
      selectedCity = widget.userData!['city'] ?? 'Ahmedabad';
      selectedState = widget.userData!['state'] ?? 'Gujarat';
      selectedGender = widget.userData!['gender'];
      selectedHobbies = List<String>.from(widget.userData!['hobbies'] ?? []);
      hobbies.forEach((key, _) {
        hobbies[key] = selectedHobbies.contains(key);
      });
      passwordController.text = widget.userData!['password'] ?? '';
      confirmPasswordController.text = widget.userData!['confirmPassword'] ?? '';
      selectedReligion = widget.userData!['religion'] ?? 'Hindu';
      casteController.text = widget.userData!['caste'] ?? '';
      subCasteController.text = widget.userData!['subCaste'] ?? '';
      higherEducationController.text = widget.userData!['higherEducation'] ?? '';
      occupationController.text = widget.userData!['occupation'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Matrimony Form',),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                widget.userData == null ? "Add New User" : "Update User",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildTextField(firstNameController, 'First Name', 'Enter First Name', Icons.person_outline, (value) => _validateName(value, 'first name')),
              const SizedBox(height: 20),
              _buildTextField(lastNameController, 'Last Name', 'Enter Last Name', Icons.person_outline, (value) => _validateName(value, 'last name')),
              const SizedBox(height: 20),
              _buildTextField(emailController, 'Email', 'Enter Email Address', Icons.email_outlined, (value) => _validateEmail(value)),
              const SizedBox(height: 20),
              _buildMobileField(),
              const SizedBox(height: 20),
              _buildDateField(),
              const SizedBox(height: 20),
              _buildStateDropdown(),
              const SizedBox(height: 20),
              _buildCityDropdown(),
              const SizedBox(height: 20),
              _buildReligionDropdown(),
              const SizedBox(height: 20),
              _buildGenderSelection(),
              const SizedBox(height: 20),
              _buildHobbiesSelection(),
              const SizedBox(height: 20),
              _buildTextField(casteController, 'Caste', 'Enter Caste', Icons.people, (value) => null),
              const SizedBox(height: 20),
              _buildTextField(subCasteController, 'Sub Caste', 'Enter Sub Caste', Icons.people, (value) => null),
              const SizedBox(height: 20),
              _buildTextField(higherEducationController, 'Higher Education', 'Enter Higher Education', Icons.school, (value) => null),
              const SizedBox(height: 20),
              _buildTextField(occupationController, 'Occupation', 'Enter Occupation', Icons.work, (value) => null),
              const SizedBox(height: 20),
              _buildPasswordField(passwordController, 'Password', 'Enter Password', (value) => _validatePassword(value)),
              const SizedBox(height: 20),
              _buildPasswordField(confirmPasswordController, 'Confirm Password', 'Re-enter Password', (value) => _validateConfirmPassword(value)),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  gradient: widget.userData == null
                      ? LinearGradient(colors: [Colors.blue, Colors.blueAccent])
                      : LinearGradient(colors: [Colors.green, Colors.greenAccent]),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: widget.userData == null ? Colors.blue.withOpacity(0.5) : Colors.green.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      widget.userData == null ? "Add User" : "Update User",
                      style: const TextStyle(fontSize: 16, color: Colors.white), // Set text color to white for contrast
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: Colors.transparent, // Set to 0 to use the shadow from the Container
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Set primary color to transparent to show gradient
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextField(TextEditingController controller, String label, String hint, IconData icon, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: validator,
    );
  }

  TextFormField _buildPasswordField(TextEditingController controller, String label, String hint, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: validator,
    );
  }

  TextFormField _buildMobileField() {
    return TextFormField(
      controller: mobileController,
      decoration: InputDecoration(
        labelText: 'Mobile Number',
        hintText: 'Enter Mobile Number',
        prefixIcon: const Icon(Icons.phone_android),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        String newValue = value.replaceAll(RegExp(r'[^0-9]'), '').substring(0, (value.length > 10 ? 10 : value.length));
        mobileController.value = TextEditingValue(text: newValue, selection: TextSelection.fromPosition(TextPosition(offset: newValue.length)));
      },
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter mobile number';
        if (value.length != 10) return 'Mobile number must be 10 digits';
        return isMobileUnique(value) ? null : 'This mobile number is already registered';
      },
    );
  }

  TextFormField _buildDateField() {
    return TextFormField(
      controller: dobController,
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        hintText: 'DD/MM/YYYY',
        prefixIcon: const Icon(Icons.calendar_today),
        suffixIcon: IconButton(
          icon: const Icon(Icons.date_range),
          onPressed: () async {
            DateTime now = DateTime.now();
            DateTime? pickedDate = await showDatePicker(context: context, initialDate: now, firstDate: DateTime(1900), lastDate: now);
            if (pickedDate != null) {
              setState(() {
                dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
              });
            }
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter date of birth';
        if (!RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$').hasMatch(value)) return 'Enter DOB in DD/MM/YYYY format';
        try {
          DateTime dob = DateFormat('dd/MM/yyyy').parseStrict(value);
          int age = DateTime.now().year - dob.year;
          if (age < 18 || age > 80) return 'Age must be between 18 and 80 years';
        } catch (e) {
          return 'Invalid date';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField<String> _buildStateDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedState,
      decoration: InputDecoration(
        labelText: 'State',
        prefixIcon: const Icon(Icons.location_city),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items: states
          .map((state) => DropdownMenuItem<String>(value: state, child: Text(state)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedState = value!;
          selectedCity = stateCityMap[selectedState]?.first ?? 'Ahmedabad'; // Reset city safely
        });
      },
      validator: (value) => value == null || value.isEmpty ? 'Please select a state' : null,
    );
  }

  DropdownButtonFormField<String> _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCity,
      decoration: InputDecoration(
        labelText: 'City',
        prefixIcon: const Icon(Icons.location_city),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items: (stateCityMap[selectedState] ?? [])
          .map((city) => DropdownMenuItem<String>(value: city, child: Text(city)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCity = value!;
        });
      },
      validator: (value) => value == null || value.isEmpty ? 'Please select a city' : null,
    );
  }

  DropdownButtonFormField<String> _buildReligionDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedReligion,
      decoration: InputDecoration(
        labelText: 'Religion',
        prefixIcon: const Icon(Icons.home),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items: religions
          .map((religion) => DropdownMenuItem<String>(value: religion, child: Text(religion)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedReligion = value!;
        });
      },
      validator: (value) => value == null || value.isEmpty ? 'Please select a religion' : null,
    );
  }

  FormField<int> _buildGenderSelection() {
    return FormField<int>(
      initialValue: selectedGender,
      validator: (value) => value == null ? 'Please select your gender' : null,
      builder: (FormFieldState<int> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Gender:", style: TextStyle(fontSize: 16)),
            Wrap(
              spacing: 20,
              runSpacing: 10,
              children: [
                _buildGenderRadio(1, 'Male', state),
                _buildGenderRadio(0, 'Female', state),
                _buildGenderRadio(2, 'Other', state),
              ],
            ),
            if (state.hasError) Padding(padding: const EdgeInsets.only(left: 12.0), child: Text(state.errorText!, style: const TextStyle(color: Colors.red, fontSize: 12))),
          ],
        );
      },
    );
  }

  Row _buildGenderRadio(int value, String label, FormFieldState<int> state) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<int>(
          value: value,
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value;
              state.didChange(value);
            });
          },
        ),
        Text(label),
      ],
    );
  }

  Column _buildHobbiesSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Hobbies:", style: TextStyle(fontSize: 16)),
        Wrap(
          spacing: 10,
          runSpacing: 5,
          children: hobbies.keys.map((hobby) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: hobbies[hobby],
                  onChanged: (value) {
                    setState(() {
                      hobbies[hobby] = value ?? false;
                    });
                  },
                ),
                Text(hobby),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      if (hobbies.values.every((hobby) => !hobby)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select at least one hobby'), duration: Duration(seconds: 2)));
        return;
      }

      selectedHobbies = hobbies.entries.where((entry) => entry.value).map((entry) => entry.key).toList();

      if (widget.userData == null) {
        myUser.addUserInList(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          number: mobileController.text,
          dob: dobController.text,
          city: selectedCity,
          gender: selectedGender!,
          hobbies: selectedHobbies,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          state: selectedState,
          religion: selectedReligion,
          caste: casteController.text,
          subCaste: subCasteController.text,
          higherEducation: higherEducationController.text,
          occupation: occupationController.text,
          country: 'INDIA',
        );
      } else {
        myUser.updateUser(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          number: mobileController.text,
          dob: dobController.text,
          city: selectedCity,
          gender: selectedGender!,
          hobbies: selectedHobbies,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          id: widget.index!,
          state: selectedState,
          religion: selectedReligion,
          caste: casteController.text,
          subCaste: subCasteController.text,
          higherEducation: higherEducationController.text,
          occupation: occupationController.text,
          country: 'INDIA',
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.userData == null ? 'User added successfully' : 'User updated successfully'), duration: const Duration(seconds: 3)));

      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  String? _validateName(String? value, String nameType) {
    if (value == null || value.isEmpty) return 'Enter $nameType';
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value)) return 'Only alphabets are allowed';
    if (value.contains(RegExp(r'\s\s+'))) return 'No consecutive spaces are allowed';
    if (value.length < 2) return '$nameType must be at least 2 characters';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Enter email address';
    if (!RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) return 'Enter a valid email address';
    if (isDisposableEmail(value)) return 'Disposable email addresses are not allowed';
    return isEmailUnique(value) ? null : 'This email is already registered';
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter password';
    if (value.length < 8) return 'Password must be at least 8 characters long';
    if (!RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$').hasMatch(value)) return 'Password must include uppercase, lowercase, number, and special character';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter confirm password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

  bool isDisposableEmail(String email) {
    const disposableEmailProviders = [
      'hotmail.com', 'outlook.com', 'mailinator.com',
      '10minutemail.com', 'temp-mail.org', 'dispostable.com',
    ];
    String domain = email.split('@').last;
    return disposableEmailProviders.contains(domain);
  }

  bool isEmailUnique(String value) => true; // Replace with your own logic.
  bool isMobileUnique(String value) => true; // Replace with your own logic.
}