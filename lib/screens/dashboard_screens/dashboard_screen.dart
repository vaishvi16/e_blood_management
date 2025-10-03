import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/widgets/bottom_navigation/custom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_app_bar/my_app_bar.dart';
import '../../widgets/my_drawer/my_drawer.dart';
import '../../widgets/my_grid_view/my_grid_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const bigBoldText = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w600,
  );
  static const smallBoldText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: MyAppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.add_call),
          ),
        ],
        title: Text("E Blood", style: TextStyle(color: Colors.black87)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(height: 5),
          Card(
            color: Colors.black54,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Donate Blood, \nSave Lives!",
                        style: TextStyle(
                          color: MyColors.whiteColor,
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "20 minutes is all that you \nneed to save someone's life.",
                          style: TextStyle(color: MyColors.whiteColor),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 45.0, top: 10),
                    child: Transform.scale(
                      scale: 3,
                      child: Image.asset(
                        "assets/logo/save_life_logo.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("User Name", style: bigBoldText),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text("Blood Group A+", style: smallBoldText),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Expanded(child: MyGridView()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
