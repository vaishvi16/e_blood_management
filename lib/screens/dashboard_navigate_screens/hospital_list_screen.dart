import 'package:e_blood_management/widgets/my_app_bar/my_app_bar.dart';
import 'package:flutter/material.dart';

class HospitalListScreen extends StatefulWidget {
  const HospitalListScreen({super.key});

  @override
  State<HospitalListScreen> createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  // List of 15 cities
  List<String> cities = [
    'Mumbai', 'Delhi', 'Bangalore', 'Hyderabad', 'Chennai',
    'Kolkata', 'Pune', 'Ahmedabad', 'Jaipur', 'Lucknow',
    'Indore', 'Bhopal', 'Nagpur', 'Surat', 'Chandigarh',
  ];

  // Currently selected city
  String selectedCity = 'Mumbai';

  // Sample hospitals mapped to each city
  Map<String, List<String>> hospitalData = {
    'Mumbai': ['Lilavati Hospital', 'Nanavati Hospital', 'Kokilaben Hospital', 'Max Healthcare'],
    'Delhi': ['AIIMS', 'Fortis Delhi'],
    'Bangalore': ['Apollo Bangalore', 'Manipal Hospital', 'Narayana Health', 'Sunshine Hospital'],
    'Hyderabad': ['Care Hospital'],
    'Chennai': ['Apollo Chennai', 'MIOT Hospital', 'Fortis Chennai'],
    'Kolkata': ['AMRI Hospital', 'Fortis Kolkata', 'Desun Hospital', 'Yashoda Hospital', 'Apollomedics'],
    'Pune': ['Jehangir Hospital', 'Ruby Hall Clinic', 'Sahyadri Hospital', 'Apex Hospital', 'Apollomedics'],
    'Ahmedabad': ['Sterling Hospital', 'Shalby Hospital', 'Zydus Hospital', 'Apex Hospital', 'Apexa Hospital'],
    'Jaipur': ['SMS Hospital', 'Fortis Jaipur', 'Apollomedics'],
    'Lucknow': ['SGPGI', 'RMLIMS', 'Apollomedics'],
    'Indore': ['Bombay Hospital', 'Choithram Hospital', 'Medanta Indore', 'Apollomedics'],
    'Bhopal': ['AIIMS Bhopal', 'Narmada Hospital', 'People\'s Hospital'],
    'Nagpur': ['Wockhardt Hospital', 'Orange City Hospital', 'KRIMS Hospital', 'Apollomedics'],
    'Surat': ['Apple Hospital', 'Shalby Surat', 'Apollomedics'],
    'Chandigarh': ['PGIMER', 'Fortis Mohali', 'Ivy Hospital', 'Apollomedics'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(centerTitle: false, title: Text('Hospitals')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Dropdown Menu for City Selection
            DropdownButton<String>(
              value: selectedCity,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCity = newValue!;
                });
              },
              items: cities.map<DropdownMenuItem<String>>((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            /// Hospital List for selected city
            Text(
              'Hospitals in $selectedCity:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: hospitalData[selectedCity]?.length ?? 0,
                itemBuilder: (context, index) {
                  final hospital = hospitalData[selectedCity]![index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.local_hospital),
                      title: Text(hospital),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
