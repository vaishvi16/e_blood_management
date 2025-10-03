import 'package:flutter/material.dart';

import '../../colors/my_colors.dart';
import '../../db_helper/db_helper.dart';
import '../../widgets/custom_fields/custom_dropdown.dart';
import '../../widgets/custom_fields/custom_textfield.dart';

class BloodRequest extends StatefulWidget {
  final int userId;

  const BloodRequest({super.key, required this.userId});

  @override
  State<BloodRequest> createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {
  TextEditingController date = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController hospitalName = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController urgency = TextEditingController();
  TextEditingController bloodGroup = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var dropDownUrgency;
  var dropDownBloodGroup;
  DbHelper dbHelper = DbHelper.instance;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomTextField(
                controller: date,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter date";
                  }
                  return null;
                },
                keyboardType: TextInputType.datetime,
                labelText: "Date",
                hintText: "Enter your Date",
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomTextField(
                controller: quantity,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter quantity";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                labelText: "Quantity",
                hintText: "Enter your Quantity",
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomTextField(
                controller: hospitalName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Hospital Name";
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                labelText: "Hospital Name",
                hintText: "Enter your Hospital Name",
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomTextField(
                controller: location,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Location";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                labelText: "Location",
                hintText: "Enter your Location",
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomDropdown(
                value: dropDownUrgency,
                labelText: "Urgency",
                items: ["High", "Medium", "Low"],
                onChanged: (val) {
                  setState(() {
                    dropDownUrgency = val;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomDropdown(
                value: dropDownBloodGroup,
                labelText: "Blood Group",
                items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"],
                onChanged: (val) {
                  setState(() {
                    dropDownBloodGroup = val;
                  });
                },
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                String dateValue = date.text.toString();
                String quantityValue = quantity.text.toString();
                String hospitalNameValue = hospitalName.text.toString();
                String locationValue = location.text.toString();
                String urgencyValue = dropDownUrgency;
                String bgroupValue = dropDownBloodGroup;

                if (_formKey.currentState!.validate()) {
                  _insertData(
                    dateValue,
                    quantityValue,
                    hospitalNameValue,
                    locationValue,
                    urgencyValue,
                    bgroupValue
                  );
                }
              },
              child: Text(
                "Submit",
                style: TextStyle(
                  color: MyColors.primaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _insertData(
    String dateValue,
    String quantityValue,
    String hospitalNameValue,
    String locationValue,
    String urgencyValue,
    String bgroupValue
  ) async {
    try {
      Map<String, dynamic> row = {
        DbHelper.columnUserId : widget.userId,
        DbHelper.columnRequestDate: dateValue,
        DbHelper.columnRequestQuantity: quantityValue,
        DbHelper.columnRequestHospitalName: hospitalNameValue,
        DbHelper.columnRequestLocation: locationValue,
        DbHelper.columnRequestUrgency: urgencyValue,
        DbHelper.columnRequestBloodGroup: bgroupValue,
      };

      print('inserted data: $row');
      final id = await dbHelper.insertBloodRequestData(row);
      print('Inserted row id: $id');

      date.clear();
      quantity.clear();
      hospitalName.clear();
      location.clear();

      setState(() {
        dropDownUrgency = null;
        dropDownBloodGroup = null;
      });
    } catch (e) {
      print('Insert failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to insert blood request data.')),
      );
    }
  }
}
