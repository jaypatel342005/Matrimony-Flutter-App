import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Profile_List.dart';
import 'export.dart';
import 'userdata.dart';

class AddUserForm extends StatefulWidget {
  final Map<String, dynamic>? userData;
  final int? index;

  const AddUserForm({Key? key, this.userData, this.index}) : super(key: key);

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final List<String> cities = [
    'Ahmedabad',
    'Surat',
    'Rajkot',
    'Morbi',
    'Jamnagar'
  ];
  String selectedCity = 'Ahmedabad';
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
      selectedCity = widget.userData!['city'] ?? cities[0];
      selectedGender = widget.userData!['gender'];
      selectedHobbies = List<String>.from(widget.userData!['hobbies'] ?? []);
      hobbies.forEach((key, _) {
        hobbies[key] = selectedHobbies.contains(key);
      });
      passwordController.text = widget.userData!['password'] ?? '';
      confirmPasswordController.text =
          widget.userData!['confirmPassword'] ?? '';
    }
  }

  bool isDisposableEmail(String email) {
    const disposableEmailProviders = [
      'hotmail.com',
      'outlook.com',
      'mailinator.com',
      '10minutemail.com',
      'temp-mail.org',
      'dispostable.com',
    ];
    String domain = email.split('@').last;
    return disposableEmailProviders.contains(domain);
  }

  bool isEmailUnique(String value) => true; // Replace with your own logic.
  bool isMobileUnique(String value) => true; // Replace with your own logic.

  @override
  Widget build(BuildContext context) {
    final cardBackground = Theme.of(context).cardColor;
    final shadowColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.black45
        : Colors.black12;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardBackground,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: shadowColor, blurRadius: 8, offset: const Offset(0, 4))
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  widget.userData == null ? "Add New User" : "Update User",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                    firstNameController,
                    'First Name',
                    'Enter First Name',
                    Icons.person_outline,
                    (value) => _validateName(value, 'first name')),
                const SizedBox(height: 20),
                _buildTextField(
                    lastNameController,
                    'Last Name',
                    'Enter Last Name',
                    Icons.person_outline,
                    (value) => _validateName(value, 'last name')),
                const SizedBox(height: 20),
                _buildTextField(emailController, 'Email', 'Enter Email Address',
                    Icons.email_outlined, (value) => _validateEmail(value)),
                const SizedBox(height: 20),
                _buildMobileField(),
                const SizedBox(height: 20),
                _buildDateField(),
                const SizedBox(height: 20),
                _buildCityDropdown(),
                const SizedBox(height: 20),
                _buildGenderSelection(),
                const SizedBox(height: 20),
                _buildHobbiesSelection(),
                const SizedBox(height: 20),
                _buildTextField(
                    passwordController,
                    'Password',
                    'Enter Password',
                    Icons.lock_outline,
                    (value) => _validatePassword(value)),
                const SizedBox(height: 20),
                _buildTextField(
                    confirmPasswordController,
                    'Confirm Password',
                    'Re-enter Password',
                    Icons.lock_outline,
                    (value) => _validateConfirmPassword(value)),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: _onSubmit,
                  child: Text(
                      widget.userData == null ? "Add User" : "Update User",
                      style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextField(TextEditingController controller, String label,
      String hint, IconData icon, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        String newValue = value
            .replaceAll(RegExp(r'[^0-9]'), '')
            .substring(0, (value.length > 10 ? 10 : value.length));
        mobileController.value = TextEditingValue(
            text: newValue,
            selection: TextSelection.fromPosition(
                TextPosition(offset: newValue.length)));
      },
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter mobile number';
        if (value.length != 10) return 'Mobile number must be 10 digits';
        return isMobileUnique(value)
            ? null
            : 'This mobile number is already registered';
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
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: now,
                  firstDate: DateTime(1900),
                  lastDate: now);
              if (pickedDate != null) {
                setState(() {
                  dobController.text =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                });
              }
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter date of birth';
        if (!RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$')
            .hasMatch(value)) return 'Enter DOB in DD/MM/YYYY format';
        try {
          DateTime dob = DateFormat('dd/MM/yyyy').parseStrict(value);
          int age = DateTime.now().year - dob.year;
          if (age < 18 || age > 80)
            return 'Age must be between 18 and 80 years';
        } catch (e) {
          return 'Invalid date';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField<String> _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCity,
      decoration: InputDecoration(
          labelText: 'City',
          prefixIcon: const Icon(Icons.location_city),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      items: cities
          .map((city) =>
              DropdownMenuItem<String>(value: city, child: Text(city)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCity = value ?? cities[0];
        });
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select a city' : null,
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
            if (state.hasError)
              Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(state.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12))),
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please select at least one hobby'),
            duration: Duration(seconds: 2)));
        return;
      }

      selectedHobbies = hobbies.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

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
          id: widget.index,
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(widget.userData == null
              ? 'User added successfully'
              : 'User updated successfully'),
          duration: const Duration(seconds: 3)));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserListPage()));
    }
  }

  String? _validateName(String? value, String nameType) {
    if (value == null || value.isEmpty) return 'Enter $nameType';
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value))
      return 'Only alphabets are allowed';
    if (value.contains(RegExp(r'\s\s+')))
      return 'No consecutive spaces are allowed';
    if (value.length < 2) return '$nameType must be at least 2 characters';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Enter email address';
    if (!RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) return 'Enter a valid email address';
    if (isDisposableEmail(value))
      return 'Disposable email addresses are not allowed';
    return isEmailUnique(value) ? null : 'This email is already registered';
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter password';
    if (value.length < 8) return 'Password must be at least 8 characters long';
    if (!RegExp(
            r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
        .hasMatch(value))
      return 'Password must include uppercase, lowercase, number, and special character';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter confirm password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }
}
