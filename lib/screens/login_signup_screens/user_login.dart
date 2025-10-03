import 'package:e_blood_management/screens/dashboard_screens/dashboard_screen.dart';
import 'package:e_blood_management/screens/login_signup_screens/signup_screen.dart';
import 'package:e_blood_management/widgets/custom_fields/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors/my_colors.dart';
import '../../db_helper/db_helper.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  DbHelper dbHelper = DbHelper.instance;
  late SharedPreferences sharedPreferences;

  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  final passwordRegex = RegExp(
    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:<>?~]).{8,}$",
  );

  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSharedPrefs();
  }

  void _initSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Email";
                  }
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                controller: email,
                labelText: "Email",
                hintText: "Enter your Email",
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Password";
                  }
                  if (!passwordRegex.hasMatch(value)) {
                    return "Password must be of at least 8 characters";
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                labelText: "Password",
                hintText: "Enter your Password",
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _handleLogin();
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Don't have an account. Sign Up",
                    style: TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    String useremail = email.text;
    String userpassword = password.text;

    Map<String, dynamic>? user = await dbHelper.checkId(
      useremail,
      userpassword,
    );

    if (user != null) {
      print("Vaishvi u did it!!! Login success");

      sharedPreferences.setBool("is_login", false);
      sharedPreferences.setString("myemail", useremail);
      sharedPreferences.setString("mypass", userpassword);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      print("Not found");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter valid credentials')));
    }
  }


}
