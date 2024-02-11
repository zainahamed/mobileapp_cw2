import 'package:flutter/material.dart';

import '../models/sports_category.dart';

class EditSportsPage extends StatefulWidget {
  final SportsCategory sportsCategory;

  // Pass the sportsList as a parameter
  final List<String> sportsList;

  EditSportsPage({required this.sportsCategory, required this.sportsList});

  @override
  _EditSportsPageState createState() => _EditSportsPageState();
}

class _EditSportsPageState extends State<EditSportsPage> {
  late TextEditingController categoryNameController;
  late String selectedSport;

  @override
  void initState() {
    super.initState();
    categoryNameController = TextEditingController(text: widget.sportsCategory.name);
    selectedSport = widget.sportsCategory.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Sports Category'),
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
              items: widget.sportsList.map<DropdownMenuItem<String>>((String value) {
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
                SportsCategory updatedCategory = SportsCategory(
                  name: selectedSport,
                );

                // Close the edit sports page and send back the updated category
                Navigator.pop(context, updatedCategory);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
