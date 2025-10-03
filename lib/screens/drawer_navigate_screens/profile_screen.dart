import 'dart:io';

import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/db_helper/db_helper.dart';
import 'package:e_blood_management/screens/login_signup_screens/tab_bar.dart';
import 'package:e_blood_management/widgets/my_app_bar/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final dbHelper = DbHelper.instance;
  List<Map<String, dynamic>> userData = [];
  var data;
  late SharedPreferences sharedPreferences;

  File? galleryFile;

  var dropDownGender; //for blood group
  var dropDownBloodGroup;

  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController urgency = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getvalue();
   _initSharedPrefs();
  }

  void _initSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MyAppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              sharedPreferences.setBool("is_login", true);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TabBarScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        imageSelectorGallery();
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: MyColors.primaryColor,
                        backgroundImage: galleryFile != null
                            ? FileImage(galleryFile!)
                            : null,
                        child: galleryFile == null
                            ? Icon(
                                Icons.camera_alt,
                                color: MyColors.whiteColor,
                                size: 50,
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                showTextFormField(
                  name,
                  "Please enter your Name! ",
                  TextInputType.name,
                  "Name",
                  "Enter your name",
                ),
                showDropDown(dropDownGender, "Gender", ["Male", "Female"]),
                showTextFormField(
                  email,
                  "Please enter your Email! ",
                  TextInputType.emailAddress,
                  "Email",
                  "Enter your email",
                ),
                showTextFormField(
                  mobile,
                  "Please enter your Contact! ",
                  TextInputType.number,
                  "Contact",
                  "Enter your contact",
                ),
                showDropDown(dropDownBloodGroup, "Blood Group", [
                  "A+",
                  "A-",
                  "B+",
                  "B-",
                  "O+",
                  "O-",
                  "AB+",
                  "AB-",
                ]),
                showTextFormField(
                  city,
                  "Please enter your City! ",
                  TextInputType.name,
                  "City",
                  "Enter your city",
                ),
                showTextFormField(
                  state,
                  "Please enter your State! ",
                  TextInputType.name,
                  "State",
                  "Enter your state",
                ),
                //---------------radio btn for urgency--------------
                //  showTextFormField(urgency, "Please enter your Urgency! ", TextInputType.number, "Contact", "Enter your contact"),
                /* Padding(
                  padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        MyColors.primaryColor,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Login Successful")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Login Failed")),
                        );
                      }
                    },
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  showTextFormField(
    TextEditingController controllerValue,
    String errorMsg,
    TextInputType keyboardType,
    String label,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: TextFormField(
        cursorColor: MyColors.primaryColor,
        controller: controllerValue,
        validator: (value) {
          if (value!.isEmpty) {
            return errorMsg;
          }
          return null;
        },
        keyboardType: keyboardType,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.primaryColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black87),
          ),
          border: OutlineInputBorder(),
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          floatingLabelStyle: TextStyle(color: MyColors.primaryColor),
          hintText: hint,
        ),
      ),
    );
  }

  showDropDown(dropDownValue, String labelText, List items) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.primaryColor,
              width: 2.0,
            ), // Color when focused
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black87),
          ),
        ),
        hint: dropDownValue == null
            ? Text(labelText, style: TextStyle(color: Colors.black87))
            : Text(dropDownValue, style: TextStyle(color: Colors.black87)),
        isExpanded: true,
        iconSize: 30.0,
        //['Male', 'Female']
        items: items.map((val) {
          return DropdownMenuItem<String>(value: val, child: Text(val));
        }).toList(),
        onChanged: (val) {
          setState(() {
            dropDownValue = val;
          });
        },
      ),
    );
  }

  imageSelectorGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        galleryFile = File(pickedFile.path);
      });
    }
  }

  getvalue() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      data = sharedPreferences.getString("myemail");
    });
  }
}
