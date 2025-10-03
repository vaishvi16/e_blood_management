import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/screens/blood_request_donate_screens/blood_donate.dart';
import 'package:e_blood_management/screens/blood_request_donate_screens/blood_request.dart';
import 'package:e_blood_management/screens/dashboard_screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../my_app_bar/my_app_bar.dart';
import '../my_drawer/my_drawer.dart';

class CustomNavBar extends StatefulWidget {
  final int userId;

  const CustomNavBar({super.key, required this.userId});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {

  late List<Widget> screens;

  @override
  void initState() {
    screens = [
      DashboardScreen(),
      DashboardScreen(),
      BloodDonate(userId: widget.userId),
      BloodRequest(),
    ];

  }
  var _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: MyAppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child:  IconButton(
              onPressed: () {
                callUs();
                print("Called us");
              },
              icon: Icon(Icons.add_ic_call_outlined),
            ),
          ),
        ],
        title: Text("E Blood", style: TextStyle(color: Colors.black87)),
        centerTitle: false,
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        selectedItemColor: MyColors.primaryDarkColor,
        unselectedItemColor: MyColors.primaryColor,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              "assets/icons/blood_donate.png",
              height: 22,
              color: MyColors.primaryDarkColor,
            ),
            icon: Image.asset(
              "assets/icons/blood_donate.png",
              height: 22,
              color: MyColors.primaryColor,
            ),
            label: "Donate",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              "assets/icons/blood_request.png",
              height: 22,
              color: MyColors.primaryDarkColor,
            ),
            icon: Image.asset(
              "assets/icons/blood_request.png",
              height: 22,
              color: MyColors.primaryColor,
            ),
            label: "Blood Request",
          ),
        ],
      ),
    );
  }

  onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  Future<void> callUs() async {
    Uri telUrl = Uri.parse('tel:8238658897');
    if (await canLaunchUrl(telUrl)) {
      await launchUrl(telUrl);
    }
  }
}
