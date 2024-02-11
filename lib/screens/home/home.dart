import 'package:flutter/material.dart';
import 'package:thesportsapp/constants/colors.dart';
import 'package:thesportsapp/services/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // create instance for logout
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgBlack,
        appBar: AppBar(
          backgroundColor: bgBlack,
          actions: [
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(bgBlack)),
                onPressed: () async {
                  await _auth.signOut();
                },
                child: const Icon(Icons.logout))
          ],
        ),
        body: Text(
          "HOME",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
