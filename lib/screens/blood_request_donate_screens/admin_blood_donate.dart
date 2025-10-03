import 'package:e_blood_management/widgets/my_app_bar/my_app_bar.dart';
import 'package:flutter/material.dart';

import '../../db_helper/db_helper.dart';
import 'edit_admin_donate_screen.dart';

class AdminBloodDonate extends StatefulWidget {
  const AdminBloodDonate({super.key});

  @override
  State<AdminBloodDonate> createState() => _AdminBloodDonateState();
}

class _AdminBloodDonateState extends State<AdminBloodDonate> {
  List<Map<String, dynamic>> _donations = [];
  DbHelper dbHelper = DbHelper.instance;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(centerTitle: false, title: Text("Donation List")),
      body: _donations.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'No donation data found.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            )
          : SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _donations.length,
                itemBuilder: (context, index) {
                  final donation = _donations[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(right: 0, left: 12),
                      title: Text(
                        'Date: ${donation['donation_date']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quantity: ${donation['quantity_ml']} ml'),
                          Text('Hospital: ${donation['hospital_name']}'),
                          Text('Location: ${donation['location']}'),
                          Text('Status: ${donation['status']}'),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) async {
                          final int donationId = donation['id'];
                          if (value == "Edit") {
                            print("Edit clicked");
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAdminDonateScreen(
                                  donationId: donationId,
                                ),
                              ),
                            );
                            if (updated == true) {
                              _fetchDonations();
                            }
                          } else if (value == "Delete") {
                            print("Delete clicked");
                            deleteData(donationId);
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(value: "Edit", child: Text("Edit")),
                          PopupMenuItem(value: "Delete", child: Text("Delete")),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Future<void> deleteData(int id) async {
    await dbHelper.deleteBloodDonateData(id);
    await _fetchDonations();
  }
}
