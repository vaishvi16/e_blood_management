import 'package:e_blood_management/screens/blood_request_donate_screens/admin_blood_donate.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/my_app_bar/my_app_bar.dart';
import '../login_signup_screens/tab_bar.dart';
import '../blood_request_donate_screens/admin_blood_request.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final List<String> titles = ["Request Blood", "Donate Blood"];
  final List<Widget> screens = [AdminBloodRequest(), AdminBloodDonate()];

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_admin_login", false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => TabBarScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: false,
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(titles[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => screens[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
