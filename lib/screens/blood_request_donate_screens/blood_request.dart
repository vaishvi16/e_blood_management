import 'package:flutter/material.dart';

import '../../widgets/my_app_bar/my_app_bar.dart';

class BloodRequest extends StatefulWidget {
  const BloodRequest({super.key});

  @override
  State<BloodRequest> createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(centerTitle: false)
    );
  }
}
