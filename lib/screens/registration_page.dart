import 'package:flutter/material.dart';
import 'package:event_app/services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _tiktokController = TextEditingController();

  String? _selectedSpeciality;
  String? _selectedCountry;
  bool _isPasswordVisible = false;
  bool _isChecked = false;

  final List<String> specialities = ["Dermatologist", "Makeup Artist", "Hairstylist"];
  final List<String> countries = ["USA", "Canada", "UK", "India"];

  final ApiService apiService = ApiService();

  void registerUser() async {
    bool success = await apiService.registerUser(_fullNameController.text, _emailController.text, _passwordController.text);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration successful!')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blueGrey.shade400,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(hintText: "Full Name"),
                  validator: (value) => value!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 3),
                Text(
                    "Enter Full Name *",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                ),

                const SizedBox(height: 10),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.contains('@') ? null : "Enter a valid email",
                ),
                Text(
                  "Enter a valid email",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Password *",
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                    ),
                  ),
                  validator: (value) => value!.length >= 6 ? null : "Password too short",
                ),
                Text(
                  "Enter a password",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: _selectedSpeciality,
                  items: specialities.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                  onChanged: (value) => setState(() => _selectedSpeciality = value),
                  decoration: InputDecoration(hintText: "Speciality *"),
                  validator: (value) => value == null ? "Required" : null,
                ),
                Text(
                  "Select Speciality",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  items: countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (value) => setState(() => _selectedCountry = value),
                  decoration: InputDecoration(hintText: "Select Country *"),
                  validator: (value) => value == null ? "Required" : null,
                ),
                Text(
                  "Select Country",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _mobileController,
                  decoration: InputDecoration(hintText: "Mobile Number *"),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.length >= 10 ? null : "Enter a valid number",
                ),
                Text(
                  "Enter Mobile Number",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _instagramController,
                  decoration: InputDecoration(hintText: "Instagram @"),
                ),
                Text(
                  "Instagram @",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _tiktokController,
                  decoration: InputDecoration(hintText: "TikTok @"),
                ),
                Text(
                  "TikTok @",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) => setState(() => _isChecked = value!),
                    ),
                    const Expanded(
                      child: Text(
                        "By ticking this box, you give your consent to L'Oréal to process the provided data for the following purposes: Fulfilling L'Oreal requirements to report and record the identity of the attendees in its activities and events Use for compliance purposes and reporting according to L'Oreal and country-specific compliance regulations and code of conduct.",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade300,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}