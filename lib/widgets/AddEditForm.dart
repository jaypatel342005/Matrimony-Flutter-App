import 'package:intl/intl.dart';
import '../services/navigation_service.dart';
import 'export.dart';

class AddEditForm extends StatefulWidget {
  final Map<String, dynamic>? userData;
  final int? index;

  const AddEditForm({super.key, this.userData, this.index});

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
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController casteController = TextEditingController();
  final TextEditingController subCasteController = TextEditingController();
  final TextEditingController higherEducationController =
      TextEditingController();
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
    'Andhra Pradesh': [
      'Visakhapatnam',
      'Vijayawada',
      'Tirupati',
      'Guntur',
      'Nellore',
      'Kurnool',
      'Rajahmundry',
      'Kadapa',
      'Anantapur',
      'Eluru',
      'Ongole',
      'Machilipatnam',
      'Chittoor',
      'Srikakulam',
      'Vizianagaram'
    ],
    'Arunachal Pradesh': [
      'Itanagar',
      'Naharlagun',
      'Pasighat',
      'Tawang',
      'Ziro',
      'Roing',
      'Bomdila'
    ],
    'Assam': [
      'Guwahati',
      'Silchar',
      'Dibrugarh',
      'Tezpur',
      'Nagaon',
      'Jorhat',
      'Tinsukia',
      'Bongaigaon',
      'Dhubri',
      'Diphu',
      'Goalpara',
      'Hailakandi'
    ],
    'Bihar': [
      'Patna',
      'Gaya',
      'Bhagalpur',
      'Muzaffarpur',
      'Darbhanga',
      'Purnia',
      'Arrah',
      'Begusarai',
      'Munger',
      'Chhapra',
      'Katihar',
      'Motihari',
      'Samastipur',
      'Sasaram',
      'Siwan'
    ],
    'Chhattisgarh': [
      'Raipur',
      'Bilaspur',
      'Durg',
      'Korba',
      'Jagdalpur',
      'Raigarh',
      'Ambikapur',
      'Rajnandgaon',
      'Mahasamund'
    ],
    'Goa': ['Panaji', 'Margao', 'Mapusa', 'Ponda', 'Vasco da Gama'],
    'Gujarat': [
      'Ahmedabad',
      'Surat',
      'Vadodara',
      'Rajkot',
      'Bhavnagar',
      'Jamnagar',
      'Junagadh',
      'Gandhinagar',
      'Anand',
      'Surendranagar',
      'Navsari',
      'Mehsana',
      'Morbi'
    ],
    'Haryana': [
      'Chandigarh',
      'Gurugram',
      'Faridabad',
      'Ambala',
      'Hisar',
      'Panipat',
      'Rohtak',
      'Karnal',
      'Yamunanagar',
      'Sonipat',
      'Sirsa',
      'Bhiwani',
      'Panchkula'
    ],
    'Himachal Pradesh': [
      'Shimla',
      'Dharamshala',
      'Solan',
      'Mandi',
      'Kullu',
      'Bilaspur',
      'Hamirpur',
      'Chamba',
      'Una',
      'Palampur'
    ],
    'Jharkhand': [
      'Ranchi',
      'Jamshedpur',
      'Dhanbad',
      'Bokaro',
      'Deoghar',
      'Hazaribagh',
      'Giridih',
      'Ramgarh',
      'Dumka',
      'Chaibasa',
      'Medininagar'
    ],
    'Karnataka': [
      'Bangalore',
      'Mysore',
      'Mangalore',
      'Hubli',
      'Belgaum',
      'Davanagere',
      'Shivamogga',
      'Tumkur',
      'Udupi',
      'Gulbarga',
      'Bellary',
      'Bidar'
    ],
    'Kerala': [
      'Thiruvananthapuram',
      'Kochi',
      'Kozhikode',
      'Kollam',
      'Thrissur',
      'Alappuzha',
      'Palakkad',
      'Malappuram',
      'Kannur',
      'Kasaragod',
      'Idukki'
    ],
    'Madhya Pradesh': [
      'Bhopal',
      'Indore',
      'Gwalior',
      'Jabalpur',
      'Ujjain',
      'Sagar',
      'Ratlam',
      'Satna',
      'Rewa',
      'Dewas',
      'Chhindwara'
    ],
    'Maharashtra': [
      'Mumbai',
      'Pune',
      'Nagpur',
      'Nashik',
      'Aurangabad',
      'Thane',
      'Solapur',
      'Kolhapur',
      'Amravati',
      'Akola',
      'Jalgaon',
      'Latur',
      'Nanded',
      'Dhule'
    ],
    'Manipur': ['Imphal', 'Thoubal', 'Bishnupur', 'Churachandpur'],
    'Meghalaya': ['Shillong', 'Tura', 'Jowai', 'Nongpoh'],
    'Mizoram': ['Aizawl', 'Lunglei', 'Champhai', 'Serchhip'],
    'Nagaland': ['Kohima', 'Dimapur', 'Mokokchung', 'Wokha'],
    'Odisha': [
      'Bhubaneswar',
      'Cuttack',
      'Berhampur',
      'Rourkela',
      'Sambalpur',
      'Balasore',
      'Puri',
      'Bhadrak',
      'Jajpur',
      'Baripada'
    ],
    'Punjab': [
      'Chandigarh',
      'Amritsar',
      'Ludhiana',
      'Jalandhar',
      'Patiala',
      'Bathinda',
      'Mohali',
      'Hoshiarpur',
      'Pathankot'
    ],
    'Rajasthan': [
      'Jaipur',
      'Udaipur',
      'Jodhpur',
      'Ajmer',
      'Bikaner',
      'Kota',
      'Alwar',
      'Bhilwara',
      'Sikar',
      'Sri Ganganagar'
    ],
    'Sikkim': ['Gangtok', 'Namchi', 'Gyalshing'],
    'Tamil Nadu': [
      'Chennai',
      'Coimbatore',
      'Madurai',
      'Tiruchirappalli',
      'Salem',
      'Erode',
      'Tirunelveli',
      'Vellore',
      'Thoothukudi'
    ],
    'Telangana': [
      'Hyderabad',
      'Warangal',
      'Nizamabad',
      'Karimnagar',
      'Khammam',
      'Ramagundam',
      'Mahbubnagar'
    ],
    'Tripura': ['Agartala', 'Belonia', 'Dharmanagar', 'Udaipur'],
    'Uttar Pradesh': [
      'Lucknow',
      'Kanpur',
      'Varanasi',
      'Agra',
      'Ghaziabad',
      'Meerut',
      'Allahabad',
      'Bareilly',
      'Moradabad',
      'Aligarh',
      'Saharanpur',
      'Gorakhpur'
    ],
    'Uttarakhand': [
      'Dehradun',
      'Haridwar',
      'Rudrapur',
      'Haldwani',
      'Roorkee',
      'Nainital'
    ],
    'West Bengal': [
      'Kolkata',
      'Siliguri',
      'Durgapur',
      'Asansol',
      'Howrah',
      'Kharagpur',
      'Malda',
      'Bardhaman'
    ],
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

  bool _formChanged = false;
  bool _isSubmitting = false;

  final List<GlobalKey<FormFieldState>> _formFieldKeys =
      List.generate(15, (index) => GlobalKey<FormFieldState>());

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

      // Fix hobby initialization
      if (widget.userData!['hobbies'] is List) {
        List<String> userHobbies =
            List<String>.from(widget.userData!['hobbies']);
        // Initialize hobbies map
        hobbies.forEach((key, _) {
          hobbies[key] = userHobbies.contains(key);
        });
        selectedHobbies = userHobbies;
      }

      passwordController.text = widget.userData!['password'] ?? '';
      confirmPasswordController.text =
          widget.userData!['confirmPassword'] ?? '';
      selectedReligion = widget.userData!['religion'] ?? 'Hindu';
      casteController.text = widget.userData!['caste'] ?? '';
      subCasteController.text = widget.userData!['subCaste'] ?? '';
      higherEducationController.text =
          widget.userData!['higherEducation'] ?? '';
      occupationController.text = widget.userData!['occupation'] ?? '';
    }
  }

  void _markFormChanged() {
    if (!_formChanged) {
      setState(() {
        _formChanged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_formChanged) {
          final result = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Discard Changes?'),
              content: const Text(
                  'You have unsaved changes. Do you want to discard them?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Discard'),
                ),
              ],
            ),
          );
          return result ?? false;
        }
        return true;
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Matrimony Form'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                _buildTextField(casteController, 'Caste', 'Enter Caste',
                    Icons.people, (value) => null),
                const SizedBox(height: 20),
                _buildTextField(subCasteController, 'Sub Caste',
                    'Enter Sub Caste', Icons.people, (value) => null),
                const SizedBox(height: 20),
                _buildTextField(higherEducationController, 'Higher Education',
                    'Enter Higher Education', Icons.school, (value) => null),
                const SizedBox(height: 20),
                _buildTextField(occupationController, 'Occupation',
                    'Enter Occupation', Icons.work, (value) => null),
                const SizedBox(height: 20),
                _buildPasswordField(
                    passwordController,
                    'Password',
                    'Enter Password',
                    (value) => _validatePassword(value),
                    false),
                const SizedBox(height: 20),
                _buildPasswordField(
                    confirmPasswordController,
                    'Confirm Password',
                    'Re-enter Password',
                    (value) => _validateConfirmPassword(value),
                    true),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: widget.userData == null
                          ? [
                              Colors.blue.shade400,
                              Colors.blue.shade600,
                              Colors.blue.shade800,
                            ]
                          : [
                              Colors.green.shade400,
                              Colors.green.shade600,
                              Colors.green.shade800,
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: widget.userData == null
                            ? Colors.blue.withOpacity(0.3)
                            : Colors.green.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                      BoxShadow(
                        color: widget.userData == null
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.green.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _isSubmitting ? null : _onSubmit,
                      borderRadius: BorderRadius.circular(15),
                      splashColor: widget.userData == null
                          ? Colors.blue.shade200
                          : Colors.green.shade200,
                      highlightColor: Colors.transparent,
                      child: Container(
                        alignment: Alignment.center,
                        child: _isSubmitting
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        widget.userData == null
                                            ? Colors.blue.shade100
                                            : Colors.green.shade100,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    widget.userData == null
                                        ? "Adding User..."
                                        : "Updating User...",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    widget.userData == null
                                        ? Icons.person_add
                                        : Icons.update,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.userData == null
                                        ? "Add User"
                                        : "Update User",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: validator,
      onChanged: (value) => _markFormChanged(),
    );
  }

  TextFormField _buildPasswordField(
      TextEditingController controller,
      String label,
      String hint,
      String? Function(String?) validator,
      bool isConfirmPassword) {
    return TextFormField(
      controller: controller,
      obscureText:
          isConfirmPassword ? _obscureConfirmPassword : _obscurePassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            isConfirmPassword
                ? (_obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility)
                : (_obscurePassword ? Icons.visibility_off : Icons.visibility),
          ),
          onPressed: () {
            setState(() {
              if (isConfirmPassword) {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              } else {
                _obscurePassword = !_obscurePassword;
              }
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: validator,
      onChanged: (value) => _markFormChanged(),
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
        String newValue = value
            .replaceAll(RegExp(r'[^0-9]'), '')
            .substring(0, (value.length > 10 ? 10 : value.length));
        mobileController.value = TextEditingValue(
          text: newValue,
          selection:
              TextSelection.fromPosition(TextPosition(offset: newValue.length)),
        );
        _markFormChanged();
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
            final now = DateTime.now();

            // Calculate date ranges for age 18-80
            final minDate = DateTime(now.year - 80, now.month, now.day);
            final maxDate = DateTime(now.year - 18, now.month, now.day);

            // Parse existing date or use max date as initial
            DateTime initialDate;
            if (dobController.text.isNotEmpty) {
              try {
                initialDate =
                    DateFormat('dd/MM/yyyy').parse(dobController.text);
                // Ensure initial date is within allowed range
                if (initialDate.isBefore(minDate)) initialDate = minDate;
                if (initialDate.isAfter(maxDate)) initialDate = maxDate;
              } catch (e) {
                initialDate = maxDate;
              }
            } else {
              initialDate = maxDate;
            }

            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: minDate,
              lastDate: maxDate,
              selectableDayPredicate: (DateTime date) {
                // Additional validation if needed
                return date
                        .isAfter(minDate.subtract(const Duration(days: 1))) &&
                    date.isBefore(maxDate.add(const Duration(days: 1)));
              },
            );

            if (pickedDate != null) {
              setState(() {
                dobController.text =
                    DateFormat('dd/MM/yyyy').format(pickedDate);
                _markFormChanged();
              });
            }
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter date of birth';
        try {
          final dob = DateFormat('dd/MM/yyyy').parseStrict(value);
          final now = DateTime.now();
          final age = now.year -
              dob.year -
              (now.month < dob.month ||
                      (now.month == dob.month && now.day < dob.day)
                  ? 1
                  : 0);

          if (age < 18 || age > 80) {
            return 'Age must be between 18 and 80 years';
          }
        } catch (e) {
          return 'Invalid date format (DD/MM/YYYY)';
        }
        return null;
      },
      onChanged: (value) => _markFormChanged(),
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
          .map((state) =>
              DropdownMenuItem<String>(value: state, child: Text(state)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedState = value!;
          selectedCity = stateCityMap[selectedState]?.first ?? 'Ahmedabad';
          _markFormChanged();
        });
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select a state' : null,
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
          .map((city) =>
              DropdownMenuItem<String>(value: city, child: Text(city)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCity = value!;
          _markFormChanged();
        });
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select a city' : null,
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
          .map((religion) =>
              DropdownMenuItem<String>(value: religion, child: Text(religion)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedReligion = value!;
          _markFormChanged();
        });
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select a religion' : null,
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
                    style: const TextStyle(color: Colors.red, fontSize: 12)),
              ),
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
              _markFormChanged();
            });
          },
        ),
        Text(label),
      ],
    );
  }

  Column _buildHobbiesSelection() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hobbies:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        final allSelected =
                            hobbies.values.every((value) => value);
                        hobbies.forEach((key, _) {
                          hobbies[key] = !allSelected;
                        });
                        _markFormChanged();
                      });
                    },
                    icon: Icon(
                      hobbies.values.every((value) => value)
                          ? Icons.clear_all
                          : Icons.select_all,
                      size: 20,
                      color: Colors.blue,
                    ),
                    label: Text(
                      hobbies.values.every((value) => value)
                          ? "Clear All"
                          : "Select All",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: hobbies.keys.map((hobby) {
                  final isSelected = hobbies[hobby] ?? false;
                  return FilterChip(
                    selected: isSelected,
                    label: Text(hobby),
                    onSelected: (bool selected) {
                      setState(() {
                        hobbies[hobby] = selected;
                        _markFormChanged();
                      });
                    },
                    selectedColor: Colors.blue.withOpacity(0.2),
                    checkmarkColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? Colors.blue : borderColor,
                        width: isSelected ? 1.5 : 1.0,
                      ),
                    ),
                    showCheckmark: true,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.blue : textColor,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.normal,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    elevation: 0,
                    pressElevation: 2,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        if (hobbies.values.every((hobby) => !hobby))
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: 8),
                Text(
                  'Please select at least one hobby',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors in the form'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Get selected hobbies
    selectedHobbies = hobbies.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selectedHobbies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one hobby'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      if (widget.userData == null) {
        await myUser.addUserInList(
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
        await myUser.updateUser(
          id: widget.userData!['id'],
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
          isLiked: widget.userData!['isLiked'] == 1,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.userData == null
                ? 'User added successfully'
                : 'User updated successfully'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );

        try {
          await NavigationService.navigateWithFade(
            const Dashboard(),
            replace: true,
          );
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Navigation error occurred'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  String? _validateName(String? value, String nameType) {
    if (value == null || value.isEmpty) return 'Enter $nameType';
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value)) {
      return 'Only alphabets are allowed';
    }
    if (value.contains(RegExp(r'\s\s+'))) {
      return 'No consecutive spaces are allowed';
    }
    if (value.length < 2) return '$nameType must be at least 2 characters';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Enter email address';
    if (!RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    if (isDisposableEmail(value)) {
      return 'Disposable email addresses are not allowed';
    }
    return isEmailUnique(value) ? null : 'This email is already registered';
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter password';
    if (value.length < 8) return 'Password must be at least 8 characters long';
    if (!RegExp(
            r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
        .hasMatch(value)) {
      return 'Password must include uppercase, lowercase, number, and special character';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter confirm password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
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
}
