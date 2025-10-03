import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/screens/dashboard_screens/admin_dashboard_screen.dart';
import 'package:e_blood_management/screens/dashboard_screens/dashboard_screen.dart';
import 'package:e_blood_management/screens/login_signup_screens/admin_login.dart';
import 'package:e_blood_management/screens/login_signup_screens/user_login.dart';
import 'package:e_blood_management/widgets/bottom_navigation/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserLogin();
  }

  Future<void> _checkUserLogin() async {
    final prefs = await SharedPreferences.getInstance();

    final isAdminLoggedIn = prefs.getBool('is_admin_login') ?? false;
    final isUserLoggedIn = prefs.getBool('is_login') ?? false;
    final userId = prefs.getInt('user_id');

    if (isAdminLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
      );
    } else if (isUserLoggedIn && userId != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomNavBar(userId: userId)),
      );
    }
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
              mainAxisSize: MainAxisSize.min,
              children: [
                 TabBar(
                  labelColor: MyColors.primaryColor,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: MyColors.primaryColor,
                  tabs: [
                    Tab(text: "Admin"),
                    Tab(text: "User"),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 400,
                  width: 300,
                  child: const TabBarView(
                    children: [
                      AdminLoginScreen(),
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
}
