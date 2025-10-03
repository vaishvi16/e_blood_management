import 'package:e_blood_management/colors/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/custom_fields/custom_textfield.dart';
import '../dashboard_screens/admin_dashboard_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final String adminEmail = "admin123@gmail.com";
  final String adminPassword = "Admin@123";

  @override
  void initState() {
    super.initState();
    _checkIfAdminLoggedIn();
  }

  Future<void> _checkIfAdminLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    bool isAdmin = prefs.getBool('is_admin_login') ?? false;
    if (isAdmin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboardScreen(),),
      );
    }
  }

  Future<void> _saveAdminSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_admin_login', true);
  }

  void _loginAdmin() {
    if (_formKey.currentState!.validate()) {
      if (emailController.text == adminEmail && passwordController.text == adminPassword) {
        _saveAdminSession();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid admin credentials")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: emailController,
              labelText: "Email",
              hintText: "Enter email",
              validator: (value) => value!.isEmpty ? "Enter email" : null,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: passwordController,
              labelText: "Password",
              hintText: "Enter password",
              validator: (value) => value!.isEmpty ? "Enter password" : null,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loginAdmin,
              child: Text("Login", style: TextStyle(
                color: MyColors.primaryColor,
                fontWeight: FontWeight.w800,
              ),),
            )
          ],
        ),
      ),
    );
  }
}
