import 'package:flutter/material.dart';
import '../models/sports_category.dart'; // Import your sports category class

class AddSportsPage extends StatefulWidget {
  @override
  _AddSportsPageState createState() => _AddSportsPageState();
}

class _AddSportsPageState extends State<AddSportsPage> {
  // List of predefined sports
  List<String> sportsList = ['Archery', 'Athletics', 'Badminton', 'Baseball', 'Basketball', 'Boxing', 'Cricket', 'Cycling', 'Fencing', 'Football', 'Golf', 'Gymnastics', 'Ice Hockey', 'Martial Arts', 'Rugby', 'Sailing', 'Skiing', 'Snowboarding', 'Softball', 'Surfing', 'Swimming', 'Table Tennis', 'Tennis', 'Volleyball', 'Wrestling'];

  // Selected sport
  String selectedSport = 'Football';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Sports Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown to select a sport
            DropdownButton<String>(
              value: selectedSport,
              onChanged: (String? newValue) {
                setState(() {
                  selectedSport = newValue!;
                });
              },
              items: sportsList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Create a new instance of SportsCategory with the selected sport
                SportsCategory newCategory = SportsCategory(
                  name: selectedSport,
                );

                // Close the add sports page and send back the new category
                Navigator.pop(context, newCategory);
              },
              child: Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}
