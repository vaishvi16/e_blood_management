import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/screens/login_signup_screens/admin_login.dart';
import 'package:e_blood_management/screens/login_signup_screens/user_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard_screens/dashboard_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {

  late SharedPreferences sharedPreferences;
  var newuser;

  @override
  void initState() {
    checklogin();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                MyColors.whiteColor,
                MyColors.whiteColor,
                MyColors.primaryColor,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Important to center content
              children: [
                // TabBar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TabBar(
                    labelColor: MyColors.primaryColor,
                    unselectedLabelColor: MyColors.blackColor,
                    indicatorColor: MyColors.primaryColor,
                    tabs: const [
                      Tab(text: "Admin"),
                      Tab(text: "User"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // TabBarView content
                Container(
                  height: 400, // Fixed height for forms
                  width: 300,  // Optional: set width if needed
                  child: TabBarView(
                    children: [
                      AdminLogin(),
                      UserLogin(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  checklogin() async {
    sharedPreferences = await SharedPreferences.getInstance();

    newuser = (sharedPreferences.getBool('is_login') ?? true);
    print("yes new user $newuser");
    if (newuser == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    }
  }
}
