import 'package:blood_donation/services/auth.dart';
import 'package:blood_donation/shared/constants.dart';
import 'package:blood_donation/shared/decorations.dart';
import 'package:blood_donation/shared/widgets/loading.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key, required this.toggle}) : super(key: key);

  final Function toggle;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();

  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            color: bgColor,
            child: const Center(
              child: Loading(),
            ),
          )
        : Container(
            decoration: linearDecoration,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text("SIGN IN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.5)),
                elevation: 0.0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: IconButton(
                        onPressed: () {
                          widget.toggle();
                        },
                        icon: const Icon(
                          Icons.signpost_outlined,
                          size: 30.0,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
              body: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDecoration.copyWith(hintText: "Email"),
                        style: inputStyle,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      TextFormField(
                        decoration:
                            inputDecoration.copyWith(hintText: "Password"),
                        style: inputStyle,
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });

                          dynamic result =
                              await _auth.signInDonor(email, password);

                          if (result.runtimeType == String) {
                            setState(() {
                              error = "$result";
                              loading = false;
                            });
                          }
                        },
                        child: const Text("sign in",
                            style:
                                TextStyle(fontSize: 22.0, letterSpacing: 2.5)),
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      Text(
                        error,
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18.0,
                            letterSpacing: 2.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
