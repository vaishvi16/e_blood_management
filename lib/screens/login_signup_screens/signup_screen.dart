import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/screens/dashboard_screens/dashboard_screen.dart';
import 'package:e_blood_management/screens/login_signup_screens/tab_bar.dart';
import 'package:e_blood_management/screens/login_signup_screens/user_login.dart';
import 'package:e_blood_management/widgets/custom_fields/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../db_helper/db_helper.dart';
import '../../widgets/custom_fields/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  DbHelper dbHelper = DbHelper.instance;
  var dropDownGender; //for blood group
  var dropDownBloodGroup;

  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  final passwordRegex = RegExp(
    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:<>?~]).{8,}$",
  );
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
 // TextEditingController urgency = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              MyColors.whiteColor,
              MyColors.whiteColor,
              MyColors.primaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Name";
                        }
                        return null;
                      },
                      keyboardType:TextInputType.name,
                      labelText: "Name",
                      hintText: "Enter your name",
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Email";
                        }
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      labelText: "Email",
                      hintText: "Enter your Email",
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Password";
                        }
                        if (!passwordRegex.hasMatch(value)) {
                          return 'Password should be of at least 8 characters and include uppercase, lowercase and letters';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      controller: password,
                      labelText: "Password",
                      hintText: "Enter your Password",
                    ),
                    SizedBox(height: 10),
                    CustomDropdown(
                      value: dropDownGender,
                      labelText: "Gender",
                      items: ["Male", "Female"],
                      onChanged: (val) {
                        setState(() {
                          dropDownGender = val;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      maxLength: 10,
                      controller: mobile,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Contact!";
                        }
                        return null;
                      },
                      keyboardType:TextInputType.number,
                      labelText: "Contact",
                      hintText: "Enter your contact",
                    ),
                    SizedBox(height: 10),
                    CustomDropdown(
                      onChanged: (val) {
                        setState(() {
                          dropDownBloodGroup = val;
                        });
                      },
                      value: dropDownBloodGroup,
                      labelText: "Blood Group",
                      items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"],
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: state,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your State!";
                        }
                        return null;
                      },
                      keyboardType:TextInputType.name,
                      labelText: "State",
                      hintText: "Enter your state",
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: city,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your City!";
                        }
                        return null;
                      },
                      keyboardType:TextInputType.name,
                      labelText: "City",
                      hintText: "Enter your city",
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        String nameValue = name.text.toString();
                        String emailValue = email.text.toString();
                        String passValue = password.text.toString();
                        String mobileValue = mobile.text.toString();
                        String cityValue = city.text.toString();
                        String stateValue =  state.text.toString();


                        if (_formKey.currentState!.validate()) {
                          //  signup(n, s, e, p);
                          insertUserData(nameValue, emailValue, passValue, mobileValue, cityValue, stateValue);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TabBarScreen(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Sign Up",
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
          ),
        ),
      ),
    );
  }

  void insertUserData(String nameValue, String emailValue, String passvalue,String mobileValue, String cityValue, String stateValue) async {
    try {
      Map<String, dynamic> row = {
        DbHelper.username: nameValue,
        DbHelper.useremail: emailValue,
        DbHelper.userpassword: passvalue,
        DbHelper.usergender: dropDownGender ?? '',
        DbHelper.usercontact: mobileValue,
        DbHelper.userbloodgrp: dropDownBloodGroup ?? '',
        DbHelper.userstate: stateValue,
        DbHelper.usercity: cityValue,
      };

      print('inserted data: $row');
      final id = await dbHelper.insertdata(row);
      print('Inserted row id: $id');

      name.clear();
      email.clear();
      password.clear();
      mobile.clear();
      city.clear();
      state.clear();
      setState(() {
        dropDownGender = null;
        dropDownBloodGroup = null;
      });

    } catch (e) {
      print('Insert failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to insert data.')),
      );
    }
  }

}
