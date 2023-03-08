import 'package:blood_donation/models/user.dart';
import 'package:blood_donation/pages/authentication/authentication.dart';
import 'package:blood_donation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DBUser?>(context);

    if (user?.uid == null) {
      return const Authentication();
    } else {
      return const Home();
    }
  }
}
