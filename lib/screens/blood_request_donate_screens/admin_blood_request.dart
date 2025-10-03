import 'package:e_blood_management/colors/my_colors.dart';
import 'package:e_blood_management/widgets/my_app_bar/my_app_bar.dart';
import 'package:flutter/material.dart';

import '../../db_helper/db_helper.dart';
import 'edit_admin_request_screen.dart';

class AdminBloodRequest extends StatefulWidget {
  const AdminBloodRequest({super.key});

  @override
  State<AdminBloodRequest> createState() => _AdminBloodRequestState();
}

class _AdminBloodRequestState extends State<AdminBloodRequest> {
  List<Map<String, dynamic>> _requests = [];
  DbHelper dbHelper = DbHelper.instance;

  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  Future<void> _fetchRequests() async {
    final requests = await DbHelper.instance.getAllRequests();
    setState(() {
      _requests = requests;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(centerTitle: false, title: Text("Requests List")),
      body: _requests.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No requests found.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      )
          : SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _requests.length,
          itemBuilder: (context, index) {
            final requests = _requests[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              elevation: 3,
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 0, left: 12),
                title: Text(
                  'Urgency: ${requests['urgency']}',
                  style: TextStyle(
                    color: MyColors.primaryDarkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date: ${requests['donation_date']}'),
                    Text('Blood Group: ${requests['blood_group']}'),
                    Text('Quantity: ${requests['quantity_ml']} ml'),
                    Text('Hospital: ${requests['hospital_name']}'),
                    Text('Location: ${requests['location']}'),
                  ],
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) async {
                    final int requestId = requests['id'];
                    if (value == "Edit") {
                      print("Edit clicked");
                      final updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditAdminRequestScreen(
                            requestId: requestId,
                          ),
                        ),
                      );
                      if (updated == true) {
                        _fetchRequests();
                      }
                    } else if (value == "Delete") {
                      print("Delete clicked");
                      deleteData(requestId);
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
    await dbHelper.deleteBloodRequestData(id);
    await _fetchRequests();
  }
}
