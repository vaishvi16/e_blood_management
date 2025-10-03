import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/screens/dashboard_screens/dashboard_screen.dart';
import 'package:e_blood_management/screens/drawer_navigate_screens/about_us_screen.dart';
import 'package:e_blood_management/screens/drawer_navigate_screens/guidelines_screen.dart';
import 'package:e_blood_management/screens/drawer_navigate_screens/profile_screen.dart';
import 'package:e_blood_management/screens/login_signup_screens/user_login.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColors.primaryColor,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 230,
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200),
                  ),
                ),
              ),
              Center(child: Image.asset("assets/logo/blood_logo.png")),
            ],
          ),
          showMenuOptions("Home", Icon(Icons.home_rounded), DashboardScreen()),
          showMenuOptions(
            "Profile",
            Icon(Icons.person_rounded),
            ProfileScreen(),
          ),
          showMenuOptions(
            "Requests",
            Icon(Icons.bloodtype_outlined),
            UserLogin(),
          ),
          showMenuOptions(
            "Guidelines to donate blood",
            Icon(Icons.note_outlined),
            GuidelinesScreen(),
          ),
          showMenuOptions(
            "Donate History",
            Icon(Icons.history_outlined),
            UserLogin(),
          ),
          showMenuOptions("Languages", Icon(Icons.language), UserLogin()),
          showMenuOptions("About Us", Icon(Icons.info), AboutUsScreen()),
          showMenuOptions("Settings", Icon(Icons.settings), UserLogin()),
        ],
      ),
    );
  }

  showMenuOptions(String title, Icon icon, screen) {
    return ListTile(
      title: Text(title, style: TextStyle(color: MyColors.whiteColor)),
      leading: icon,
      iconColor: MyColors.whiteColor,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
