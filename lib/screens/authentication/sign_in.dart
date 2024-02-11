import 'package:flutter/material.dart';
import 'package:thesportsapp/constants/colors.dart';
import 'package:thesportsapp/constants/description.dart';
import 'package:thesportsapp/constants/styles.dart';
import 'package:thesportsapp/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  const SignIn({super.key, required this.toggle});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //connection with auth clas method
  final AuthServices _auth = AuthServices();

  //form key
  final _formKey = GlobalKey<FormState>();
  //email password vari
  String email = "";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgBlack,
        appBar: AppBar(
          title: const Text(
            "SIGN IN",
            style: TextStyle(color: mainBlue, fontWeight: FontWeight.w800),
          ),
          backgroundColor: bgBlack,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 50),
            child: Column(
              children: [
                const Text(
                  descripion,
                  style: descriptionStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: Image.asset(
                  'assets/images/login.png',
                  height: 200,
                )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //email
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: textInputdecoration,
                            validator: (val) => val?.isEmpty == true
                                ? "Enter a valid email"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //password
                          TextFormField(
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            decoration: textInputdecoration.copyWith(
                                hintText: "Password"),
                            validator: (val) => val!.length < 6
                                ? "Enter a valid password"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red),
                          ),
                          //google
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Log with Google",
                            style: descriptionStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            //signin method
                            onTap: () {},
                            child: Center(
                                child: Image.asset(
                              'assets/images/google.png',
                              height: 50,
                            )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //register
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Do not have an account?",
                                style: descriptionStyle,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // go to the regi page
                                  widget.toggle();
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      color: mainBlue,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          //button
                          const SizedBox(
                            height: 20,
                          ),
                          //Login button
                          GestureDetector(
                            onTap: () async {
                              dynamic result = await _auth
                                  .signInUsingEmailAndPassword(email, password);

                              if (result == null) {
                                setState(() {
                                  error = "Invalid User Credential";
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: (BoxDecoration(
                                  color: textLight,
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 2, color: mainYellow))),
                              child: const Center(
                                  child: Text(
                                "LOG IN",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )),
                            ),
                          ),
                          //anon
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _auth.signInAnonymously();
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: (BoxDecoration(
                                  color: textLight,
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 2, color: mainYellow))),
                              child: const Center(
                                  child: Text(
                                "GUEST USER",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }
}

// ElevatedButton(
//         child: const Text("Sign in Anony"),
//         onPressed: () async {
//           dynamic resulut = await _auth.signInAnonymously();
//           if (resulut == Null) {
//             print("Error in signing");
//           } else {
//             print("signed Anon");
//             print(resulut.uid);
//           }
//         },
//       ),