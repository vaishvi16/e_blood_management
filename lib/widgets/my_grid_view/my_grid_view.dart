import 'package:e_blood_management/colors/my_colors.dart';
import 'package:flutter/material.dart';

class MyGridView extends StatefulWidget {
  const MyGridView({super.key});

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
            return Container(
              //margin: EdgeInsets.only(left: 10),
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
            );
          },
        ),
      ),
    );
  }
}
