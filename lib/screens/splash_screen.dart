import 'dart:async';

import 'package:e_blood_management/screens/dashboard_screens/dashboard_screen.dart';
import 'package:e_blood_management/screens/login_signup_screens/admin_login.dart';
import 'package:e_blood_management/screens/login_signup_screens/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lottie/lottie.dart';

import 'network_error/network_error.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  @override
  initState() {
    super.initState();

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
        List<ConnectivityResult> result,
        ) {
      if (result.contains(ConnectivityResult.mobile)) {
        Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TabBarScreen()),
          ),
        );
      } else if (result.contains(ConnectivityResult.wifi)) {
        Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TabBarScreen()),
          ),
        );
      } else if (result.contains(ConnectivityResult.none)) {
        Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NetworkError()),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Center(child: Image.asset("assets/logo/blood_logo.png")),
      ),
    );
  }
}
