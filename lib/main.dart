import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/screens/login_signup_screens/tab_bar.dart';
import 'package:e_blood_management/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Hide system UI (status bar + navigation bar)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);


  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: MyColors.primaryColor),
      home: SplashScreen(),
    ),
  );
}
