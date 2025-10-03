import 'package:flutter/material.dart';

import '../../colors/my_colors.dart';
import '../../db_helper/db_helper.dart';
import '../../widgets/custom_fields/custom_dropdown.dart';
import '../../widgets/custom_fields/custom_textfield.dart';

class EditAdminRequestScreen extends StatefulWidget {
  final int requestId;

  const EditAdminRequestScreen({required this.requestId});

  @override
  State<EditAdminRequestScreen> createState() => _EditAdminRequestScreenState();
}

class _EditAdminRequestScreenState extends State<EditAdminRequestScreen> {

  late TextEditingController date;
  late TextEditingController quantity;
  late TextEditingController hospitalName;
  late TextEditingController location;

  final _formKey = GlobalKey<FormState>();
  var dropDownbloodGroup;//for blood group
  var dropDownurgency;

  DbHelper dbHelper = DbHelper.instance;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    _loadDonationData();
  }

  Future<void> _loadDonationData() async {
    // Fetch request data by ID from DB
    final request = await dbHelper.getRequestById(widget.requestId);

    // Initialize controllers with fetched data
    date = TextEditingController(text: request[DbHelper.columnRequestDate]);
    quantity = TextEditingController(
      text: request[DbHelper.columnRequestQuantity].toString(),
    );
    hospitalName = TextEditingController(
      text: request[DbHelper.columnRequestHospitalName],
    );
    location = TextEditingController(text: request[DbHelper.columnRequestLocation]);
    dropDownurgency = request[DbHelper.columnRequestUrgency];
    dropDownbloodGroup = request[DbHelper.columnRequestBloodGroup];


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
                  value: dropDownurgency,
                  labelText: "Urgency",
                  items: ["High", "Medium", "Low"],
                  onChanged: (val) {
                    setState(() {
                      dropDownurgency = val;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomDropdown(
                  value: dropDownbloodGroup,
                  labelText: "Blood Group",
                  items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"],
                  onChanged: (val) {
                    setState(() {
                      dropDownbloodGroup = val;
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
    final updateRequestedData = {
      DbHelper.requestId: widget.requestId,
      DbHelper.columnRequestDate: date.text,
      DbHelper.columnRequestQuantity: quantity.text,
      DbHelper.columnRequestHospitalName: hospitalName.text,
      DbHelper.columnLocation: location.text,
      DbHelper.columnRequestUrgency: dropDownurgency,
      DbHelper.columnRequestBloodGroup: dropDownbloodGroup,
    };

    await dbHelper.updateBloodRequestData(updateRequestedData);
    Navigator.pop(context, true);
  }
}
