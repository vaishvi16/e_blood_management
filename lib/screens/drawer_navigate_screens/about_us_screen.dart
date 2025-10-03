import 'package:e_blood_management/widgets/my_app_bar/my_app_bar.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(centerTitle: true, title: const Text("About Us")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/blood_image_bg.jpg",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                """Welcome to the Blood Donation Management System — a digital platform designed to connect blood donors with those in need, quickly and efficiently.

Our mission is to streamline the blood donation process by bridging the gap between donors, recipients, and blood banks. Through this app, users can register as donors, request blood, track donation history, and receive real-time updates about urgent needs in their area.

We believe that every drop counts. By making blood donation more accessible and organized, we aim to save lives and build a stronger, more responsive community.

Whether you're a first-time donor or a regular contributor, your role is vital. Together, we can make a difference.

Thank you for being a part of this life-saving mission.""",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
