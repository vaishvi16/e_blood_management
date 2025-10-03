import 'package:e_blood_management/widgets/my_app_bar/my_app_bar.dart';
import 'package:flutter/material.dart';

import '../../db_helper/db_helper.dart';
import '../../widgets/custom_fields/custom_textfield.dart';

class BloodDonate extends StatefulWidget {
  const BloodDonate({super.key});

  @override
  State<BloodDonate> createState() => _BloodDonateState();
}

class _BloodDonateState extends State<BloodDonate> {
  List<Map<String, dynamic>> _donations = [];

  @override
  void initState() {
    super.initState();
    _fetchDonations();
  }

  Future<void> _fetchDonations() async {
    final donations = await DbHelper.instance.getAllDonations();
    setState(() {
      _donations = donations;
    });
  }

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(centerTitle: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _donations.length,
              itemBuilder: (context, index) {
                final donation = _donations[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      'Date: ${donation['donation_date']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Blood Group: ${donation['blood_group']}'),
                        Text('Quantity: ${donation['quantity_ml']} ml'),
                        Text('Hospital: ${donation['hospital_name']}'),
                        Text('Location: ${donation['location']}'),
                        Text('Status: ${donation['status']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: password,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your Password";
                }
                return null;
              },
              keyboardType: TextInputType.name,
              labelText: "Password",
              hintText: "Enter your Password",
            ),
          ],
        ),
      ),
    );
  }
}
