import 'package:e_blood_management/widgets/my_app_bar/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Make sure this is added to pubspec.yaml

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() => _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  final List<Map<String, String>> emergencyContacts = [
    {'title': 'Ambulance', 'number': '102'},
    {'title': 'Police', 'number': '100'},
    {'title': 'Fire Brigade', 'number': '101'},
    {'title': 'Disaster Management', 'number': '108'},
    {'title': 'Women Helpline', 'number': '1091'},
    {'title': 'Child Helpline', 'number': '1098'},
    {'title': 'Blood Helpline', 'number': '104'},
    {'title': 'Railway Enquiry', 'number': '139'},
    {'title': 'National Emergency Number', 'number': '112'},
  ];

  // Launch dialer with the given phone number
  void _callNumber(String number) async {
    final Uri url = Uri.parse('tel:$number');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch phone dialer')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: false,
        title: Text('Emergency Contacts'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: emergencyContacts.length,
        itemBuilder: (context, index) {
          final contact = emergencyContacts[index];
          return Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.phone, color: Colors.red),
              title: Text(contact['title']!),
              trailing: Text(contact['number']!),
              onTap: () => _callNumber(contact['number']!),
            ),
          );
        },
      ),
    );
  }
}
