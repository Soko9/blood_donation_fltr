import 'dart:developer';

import 'package:blood_donation/models/donor/donor.dart';
import 'package:blood_donation/models/post/post.dart';
import 'package:blood_donation/models/user.dart';
import 'package:blood_donation/services/firestore.dart';
import 'package:blood_donation/shared/decorations.dart';
import 'package:blood_donation/shared/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class PostPanel extends StatefulWidget {
  const PostPanel({Key? key}) : super(key: key);

  @override
  State<PostPanel> createState() => _PostPanelState();
}

class _PostPanelState extends State<PostPanel> {
  final FirestoreService _firestore = FirestoreService();

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

  String blood = "A+";
  int units = 0;
  String location = "Beirut";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DBUser>(context);

    return loading
        ? const Center(
            child: Loading(),
          )
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text("Create Donation Post",
                      style: TextStyle(fontSize: 22.0, letterSpacing: 2.5)),
                  const SizedBox(
                    height: 44.0,
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
                    decoration:
                        inputDecoration.copyWith(hintText: "# Units wanted"),
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
                    decoration: inputDecoration.copyWith(hintText: "Location"),
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
                  OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _firestore.getDonorByID(user.uid);
                      Donor donor = Donor(
                        result.data()["name"],
                        result.data()["dob"],
                        result.data()["blood"],
                        result.data()["units"],
                        result.data()["gender"],
                        result.data()["location"],
                        result.data()["email"],
                      );
                      inspect(donor);
                      Post post =
                          Post(blood, units, location, donor, Timestamp.now());
                      inspect(post);
                      await _firestore.addPost(post);
                      if (!mounted) {
                        return;
                      }
                      Navigator.pop(context);
                      setState(() {
                        loading = false;
                      });
                    },
                    child: const Text("post",
                        style: TextStyle(fontSize: 22.0, letterSpacing: 2.5)),
                  ),
                ],
              ),
            ),
          );
  }
}
