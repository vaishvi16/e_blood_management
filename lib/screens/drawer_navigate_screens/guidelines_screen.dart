import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/widgets/my_app_bar/my_app_bar.dart';
import 'package:flutter/material.dart';

class GuidelinesScreen extends StatelessWidget {
  const GuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: true,
        title: Text("Guidelines to Donate Blood"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: showHeadings("Good Health"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  showPoints(
                    "You must be in good general health and feeling well on the day of donation. ",
                  ),
                  showPoints(
                    "Do not donate if you have a cold, flu, sore throat, stomach bug, or any other infection. ",
                  ),
                  showPoints(
                    "Your blood pressure, pulse rate, and body temperature will be checked to ensure they are within normal limits. ",
                  ),
                  showPoints(
                    "A minimum haemoglobin level of 12.5 g/dL is required for women, and 13.0 g/dL for men, to ensure you can donate safely.",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: showHeadings("Age & Weight"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  showPoints(
                    "You must be at least 17 years old. Some states allow 16-year-olds to donate with parental consent.",
                  ),
                  showPoints(
                    "You need to weigh at least 110 pounds (approximately 50 kg).",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: showHeadings("What to Do Before Donating"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  showPoints(
                    "Consume a full meal within four hours of donating, avoiding fried, fatty foods and whole dairy products.",
                  ),
                  showPoints(
                    "Drink plenty of non-alcoholic, non-caffeinated beverages.",
                  ),
                  showPoints(
                    "Get plenty of sleep the night before your donation.",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: showHeadings("What to Avoid"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  showPoints(
                    "Do not drink alcohol for several hours before and after donating. ",
                  ),
                  showPoints(
                    "Avoid donating if you have recently had a tattoo or body piercing. ",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: showHeadings("After Donating"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  showPoints(
                    "Continue to drink plenty of fluids and stay hydrated. ",
                  ),
                  showPoints(
                    " If you feel faint or dizzy, lie down immediately and raise your feet. ",
                  ),
                  showPoints(
                    " Refrain from heavy lifting for several hours after the donation.  ",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showPoints(String title) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(child: Text(title, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  showHeadings(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
    );
  }
}
