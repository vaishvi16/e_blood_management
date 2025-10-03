import 'package:e_blood_management/colors/my_colors.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }

  onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
