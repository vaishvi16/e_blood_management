import 'package:e_blood_management/colors/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db_helper/db_helper.dart';
import '../../widgets/my_grid_view/my_grid_view.dart';

class DashboardScreen extends StatefulWidget {
  final int userId;

  const DashboardScreen({super.key, required this.userId});


  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late SharedPreferences sharedPreferences;
  final dbHelper = DbHelper.instance;

  String name = '';
  String bloodGroup = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initSharedPrefs();
  }

  void _initSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    int? userId = sharedPreferences.getInt("user_id");

    if (userId != null) {
      Map<String, dynamic>? user = await dbHelper.getDetailsFromId(userId);
      if (user != null) {
        setState(() {
          name = user[DbHelper.username] ?? '';
          bloodGroup = user[DbHelper.userbloodgrp] ?? '';
          isLoading = false;
        });
      } else {
        print("User not found in DB.");
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print("User ID not found in SharedPreferences.");
      setState(() {
        isLoading = false;
      });
    }
  }

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
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
      children: [
        const SizedBox(height: 5),
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
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
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
                          child: Text(
                            name.isNotEmpty ? name : 'User',
                            style: bigBoldText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            bloodGroup.isNotEmpty
                                ? "Blood Group: $bloodGroup"
                                : "Blood Group: -",
                            style: smallBoldText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(child: MyGridView(userId: widget.userId)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
