import 'package:e_blood_management/widgets/my_app_bar/my_app_bar.dart';
import 'package:flutter/material.dart';

class BloodBanksScreen extends StatefulWidget {
  const BloodBanksScreen({super.key});

  @override
  State<BloodBanksScreen> createState() => _BloodBanksScreenState();
}

class _BloodBanksScreenState extends State<BloodBanksScreen> {
  // List of cities
  final List<String> cities = [
    'Mumbai', 'Delhi', 'Bangalore', 'Hyderabad', 'Chennai',
    'Kolkata', 'Pune', 'Ahmedabad', 'Jaipur', 'Lucknow',
    'Indore', 'Bhopal', 'Nagpur', 'Surat', 'Chandigarh',
  ];

  // Currently selected city
  String selectedCity = 'Mumbai';

  // Sample blood bank data per city
  final Map<String, List<String>> bloodBankData = {
    'Mumbai': ['Red Cross Blood Bank', 'KEM Hospital Blood Bank', 'Jaslok Blood Bank'],
    'Delhi': ['AIIMS Blood Bank', 'Apollo Blood Centre', 'Rotary Blood Bank'],
    'Bangalore': ['NIMHANS Blood Bank', 'Victoria Hospital Blood Bank', 'Rashtrotthana Blood Centre'],
    'Hyderabad': ['Osmania Hospital Blood Bank', 'Red Cross Hyderabad', 'Nilofer Blood Centre'],
    'Chennai': ['Stanley Hospital Blood Bank', 'Jeevan Blood Bank', 'Madras Medical Mission'],
    'Kolkata': ['Red Cross Kolkata', 'NRS Hospital Blood Bank', 'Mission Hospital'],
    'Pune': ['Sasoon Hospital Blood Bank', 'Acharya Blood Bank', 'Ruby Hall Blood Centre'],
    'Ahmedabad': ['Civil Hospital Blood Bank', 'Prathama Blood Centre', 'Red Cross Ahmedabad'],
    'Jaipur': ['SMS Hospital Blood Bank', 'Mahatma Gandhi Blood Bank', 'Santokba Durlabhji Blood Centre'],
    'Lucknow': ['SGPGI Blood Bank', 'KGMU Blood Bank', 'RML Blood Centre'],
    'Indore': ['Choithram Hospital Blood Bank', 'Bombay Hospital Blood Bank', 'Medilink Blood Centre'],
    'Bhopal': ['Hamidia Hospital Blood Bank', 'AIIMS Bhopal Blood Centre', 'People’s Hospital Blood Bank'],
    'Nagpur': ['IGMC Blood Bank', 'Wockhardt Hospital Blood Centre', 'Lata Mangeshkar Blood Bank'],
    'Surat': ['New Civil Hospital Blood Bank', 'Red Cross Surat', 'Kiran Hospital Blood Centre'],
    'Chandigarh': ['PGI Blood Bank', 'GMCH-32 Blood Centre', 'Fortis Mohali Blood Bank'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(centerTitle: false, title: Text('Blood Banks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Dropdown Menu
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

            /// Header
            Text(
              'Blood Banks in $selectedCity:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            /// Blood Bank List
            Expanded(
              child: ListView.builder(
                itemCount: bloodBankData[selectedCity]?.length ?? 0,
                itemBuilder: (context, index) {
                  final bank = bloodBankData[selectedCity]![index];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(Icons.bloodtype, color: Colors.red),
                      title: Text(bank),
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
