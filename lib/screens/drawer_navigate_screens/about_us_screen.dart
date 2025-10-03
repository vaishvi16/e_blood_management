import 'package:e_blood_management/widgets/my_app_bar/my_app_bar.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(centerTitle: true, title: Text("About Us"),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/images/blood_image_bg.jpg", height: 100,width: 200,),),
          ],
        ),
      ),
    );
  }
}
