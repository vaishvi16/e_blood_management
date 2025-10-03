import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/screens/blood_request_donate_screens/admin_blood_donate.dart';
import 'package:e_blood_management/screens/dashboard_screens/dashboard_screen.dart';
import 'package:e_blood_management/screens/drawer_navigate_screens/about_us_screen.dart';
import 'package:e_blood_management/screens/drawer_navigate_screens/donation_list.dart';
import 'package:e_blood_management/screens/drawer_navigate_screens/guidelines_screen.dart';
import 'package:e_blood_management/screens/drawer_navigate_screens/profile_screen.dart';
import 'package:e_blood_management/screens/drawer_navigate_screens/request_list.dart';
import 'package:e_blood_management/screens/login_signup_screens/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          Expanded(
            child: ListView(
              children: [
                showMenuOptions("Profile", Icon(Icons.person_rounded), ProfileScreen()),
                showMenuOptions("Requests", Icon(Icons.bloodtype_outlined), RequestList()),
                showMenuOptions("Guidelines to donate blood", Icon(Icons.note_outlined), GuidelinesScreen()),
                showMenuOptions("Donation List", Icon(Icons.history_outlined), DonationList()),
                showMenuOptions("About Us", Icon(Icons.info), AboutUsScreen()),
              ],
            ),
          ),
          Divider(color: MyColors.whiteColor),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Logout", style: TextStyle(color: MyColors.whiteColor)),
              leading: Icon(Icons.logout, color: MyColors.whiteColor),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool("is_login", false);
                await prefs.remove("user_id"); // Optional: Clear user ID
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TabBarScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  showMenuOptions(String title, Icon icon, Widget screen) {
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
