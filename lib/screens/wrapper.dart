import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesportsapp/models/UserModel.dart';
import 'package:thesportsapp/screens/authentication/authenticate.dart';
import 'package:thesportsapp/screens/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return MaterialApp(
        home: Authenticate(),
      );
    } else {
      return Home();
    }
  }
}
