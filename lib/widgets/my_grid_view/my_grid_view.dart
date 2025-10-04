import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/screens/blood_request_donate_screens/blood_request.dart';
import 'package:e_blood_management/widgets/my_app_bar/my_app_bar.dart';
import 'package:flutter/material.dart';

import '../../screens/dashboard_navigate_screens/blood_banks_screen.dart';
import '../../screens/dashboard_navigate_screens/emerygency_contacts_screen.dart';
import '../../screens/dashboard_navigate_screens/hospital_list_screen.dart';

class MyGridView extends StatefulWidget {
  final int userId;

  const MyGridView({super.key, required this.userId});

  @override
  State<MyGridView> createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  static const bigBoldText = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w600,
  );
  static const smallBoldText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  List cardIconList = [
    Icons.local_hospital_outlined,
    Icons.add_call,
    Icons.bloodtype_outlined,
    Icons.location_on_outlined,
    Icons.search_outlined,
    Icons.clean_hands_outlined,
  ];
  List cardNameList = [
    "Hospital",
    "Emergency \nContacts",
    "Blood \nBanks",
    "Nearby \nDonors",
    "Search \nDonors",
    "Request \nFor Blood",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(12.00),
        child: GridView.builder(
          itemCount: cardNameList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                navigateToPage(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Icon(cardIconList[index], size: 50),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(cardNameList[index], style: bigBoldText)],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HospitalListScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmergencyContactsScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BloodBanksScreen()),
        );
        break;
      case 3:
        // Navigator.pop(context);
        break;
      case 4:
        //  Navigator.pop(context);
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Scaffold(
                    appBar: MyAppBar(
                      title: Text("E Blood", style: TextStyle(color: Colors.black87)),
                      centerTitle: false,
                    ),
                    body: BloodRequest(userId: widget.userId)),
          ),
        );
        break;
    }
  }
}
