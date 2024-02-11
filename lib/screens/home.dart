import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thesportsapp/constants/colors.dart';
import 'package:thesportsapp/services/auth.dart';

import '../models/sports_category.dart';
import 'add_sports_page.dart';
import 'category_details.dart';
import 'edit_sports_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

List<String> sportsList = [
  'Archery',
  'Athletics',
  'Badminton',
  'Baseball',
  'Basketball',
  'Boxing',
  'Cricket',
  'Cycling',
  'Fencing',
  'Football',
  'Golf',
  'Gymnastics',
  'Ice Hockey',
  'Martial Arts',
  'Rugby',
  'Sailing',
  'Skiing',
  'Snowboarding',
  'Softball',
  'Surfing',
  'Swimming',
  'Table Tennis',
  'Tennis',
  'Volleyball',
  'Wrestling'
];

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();
  List<SportsCategory> sportsCategories = [];
  final String categoriesKey = 'categories';

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? savedCategories = prefs.getStringList(categoriesKey);

    if (savedCategories != null) {
      setState(() {
        sportsCategories = savedCategories
            .map((category) => SportsCategory(name: category))
            .toList();
      });
    }
  }

  Future<void> _saveCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> categoryNames =
    sportsCategories.map((category) => category.name).toList();
    prefs.setStringList(categoriesKey, categoryNames);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sports Categories'),
          actions: [
            ElevatedButton(
              style: const ButtonStyle(
                // backgroundColor: MaterialStatePropertyAll(bgBlack),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
              child: const Icon(Icons.logout),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: sportsCategories.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(sportsCategories[index].name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditSportsPage(
                              sportsCategory: sportsCategories[index],
                              sportsList: sportsList,
                            ),
                          ),
                        );

                        if (result != null && result is SportsCategory) {
                          setState(() {
                            sportsCategories[index] = result;
                            _saveCategories();
                          });
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          sportsCategories.removeAt(index);
                          _saveCategories();
                        });
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDetails(
                        sportsCategory: sportsCategories[index],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSportsPage(),
              ),
            );

            if (result != null && result is SportsCategory) {
              setState(() {
                sportsCategories.add(result);
                _saveCategories();
              });
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
