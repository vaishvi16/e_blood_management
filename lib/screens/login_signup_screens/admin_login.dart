import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/widgets/custom_fields/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../dashboard_screens/admin_dashboard_screen.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
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
  Widget build(BuildContext context) {
    return Form(
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
                String emailValue = email.text.toString();
                String passValue = password.text.toString();

                if (_formKey.currentState!.validate()) {
                  //  signup(n, s, e, p);

                  if (emailValue == "admin123@gmail.com" &&
                      passValue == "Admin@123") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminDashboardScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please enter valid email and password!"),
                      ),
                    );
                  }
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
          ],
        ),
      ),
    );
  }
}
