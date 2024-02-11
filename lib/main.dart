import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesportsapp/models/UserModel.dart';
import 'package:thesportsapp/screens/wrapper.dart';
import 'package:thesportsapp/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyBWwWXi7uKeQUirUZx2B3cMbxp7LI56jMI",
            appId: "1:734622043830:android:f002afee8970b8144fe017",
            messagingSenderId: "734622043830",
            projectId: "thesportsapp-b47c6",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      initialData: UserModel(uid: ""),
      value: AuthServices().user,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
