import 'dart:developer';
import 'package:blood_donation/models/donor/donor.dart';
import 'package:blood_donation/services/auth.dart';
import 'package:blood_donation/shared/constants.dart';
import 'package:blood_donation/shared/decorations.dart';
import 'package:blood_donation/shared/widgets/loading.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.toggle}) : super(key: key);

  final Function toggle;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();

  final List<String> bloods = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-"
  ];

  final List<String> locations = [
    "Beirut",
    "Saida",
    "Tyre",
    "Tripoli",
    "Biqaa",
    "Jounieh",
    "Jbeil",
    "Batroun"
  ];

  String name = "";
  String dob = "";
  String blood = "A+";
  int units = 0;
  String location = "Beirut";
  String gender = "Male";
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
                title: const Text("REGISTER",
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
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 26.0, vertical: 18.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: inputDecoration.copyWith(hintText: "Name"),
                        style: inputStyle,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      TextFormField(
                        decoration: inputDecoration.copyWith(
                            hintText: "Birth Date (1-11-2001)"),
                        style: inputStyle,
                        onChanged: (value) {
                          setState(() {
                            dob = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      DropdownButtonFormField(
                        isExpanded: true,
                        decoration:
                            inputDecoration.copyWith(hintText: "Blood Type"),
                        value: blood,
                        icon: const Icon(Icons.arrow_drop_down_rounded,
                            color: Colors.red),
                        iconSize: 42.0,
                        items: bloods
                            .map((b) => DropdownMenuItem(
                                  value: b,
                                  child: Text(b),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            blood = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      TextFormField(
                        decoration: inputDecoration.copyWith(
                            hintText: "# Units donated before"),
                        style: inputStyle,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            units = int.parse(value);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      DropdownButtonFormField(
                        isExpanded: true,
                        decoration:
                            inputDecoration.copyWith(hintText: "Location"),
                        value: location,
                        icon: const Icon(Icons.arrow_drop_down_rounded,
                            color: Colors.red),
                        iconSize: 42.0,
                        items: locations
                            .map((l) => DropdownMenuItem(
                                  value: l,
                                  child: Text(l),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            location = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      DropdownButtonFormField(
                        isExpanded: true,
                        decoration:
                            inputDecoration.copyWith(hintText: "Gender"),
                        value: gender,
                        icon: const Icon(Icons.arrow_drop_down_rounded,
                            color: Colors.red),
                        iconSize: 42.0,
                        items: ["Male", "Female"]
                            .map((g) => DropdownMenuItem(
                                  value: g,
                                  child: Text(g),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
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
                        obscureText: true,
                        decoration:
                            inputDecoration.copyWith(hintText: "Password"),
                        style: inputStyle,
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
                          Donor current = Donor(
                              name, dob, blood, units, gender, location, email);
                          inspect(current);
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.registerDonor(
                              email, password, current);

                          if (result.runtimeType == String) {
                            setState(() {
                              error = "$result";
                              loading = false;
                            });
                          }
                        },
                        child: const Text("register",
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
