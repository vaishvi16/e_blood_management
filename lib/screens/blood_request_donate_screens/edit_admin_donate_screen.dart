import 'package:flutter/material.dart';

import '../../colors/my_colors.dart';
import '../../db_helper/db_helper.dart';
import '../../widgets/custom_fields/custom_dropdown.dart';
import '../../widgets/custom_fields/custom_textfield.dart';

class EditAdminDonateScreen extends StatefulWidget {
  final int donationId;

  const EditAdminDonateScreen({required this.donationId});

  @override
  State<EditAdminDonateScreen> createState() => _EditAdminDonateScreenState();
}

class _EditAdminDonateScreenState extends State<EditAdminDonateScreen> {
  late TextEditingController date;
  late TextEditingController quantity;
  late TextEditingController hospitalName;
  late TextEditingController status;
  late TextEditingController location;

  final _formKey = GlobalKey<FormState>();
  var dropDownStatus; //for blood group
  DbHelper dbHelper = DbHelper.instance;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    _loadDonationData();
  }

  Future<void> _loadDonationData() async {
    // Fetch donation data by ID from DB
    final donation = await dbHelper.getDonationById(widget.donationId);

    // Initialize controllers with fetched data
    date = TextEditingController(text: donation[DbHelper.columnDonationDate]);
    quantity = TextEditingController(
      text: donation[DbHelper.columnQuantity].toString(),
    );
    hospitalName = TextEditingController(
      text: donation[DbHelper.columnHospitalName],
    );
    location = TextEditingController(text: donation[DbHelper.columnLocation]);
    dropDownStatus = donation[DbHelper.columnStatus];

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  value: dropDownStatus,
                  labelText: "Status",
                  items: ["Pending", "Donated"],
                  onChanged: (val) {
                    setState(() {
                      dropDownStatus = val;
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updateData();
                  }
                },
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateData() async {
    final updateDonationData = {
      DbHelper.donationId: widget.donationId,
      DbHelper.columnDonationDate: date.text,
      DbHelper.columnQuantity: quantity.text,
      DbHelper.columnHospitalName: hospitalName.text,
      DbHelper.columnLocation: location.text,
      DbHelper.columnStatus: dropDownStatus ?? status.text,
    };

    await dbHelper.updateBloodDonateData(updateDonationData);
    Navigator.pop(context, true);
  }
}
