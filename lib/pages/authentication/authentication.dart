import 'package:blood_donation/pages/authentication/register.dart';
import 'package:blood_donation/pages/authentication/sign_in.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isSignIn = true;

  void toggle() => setState(() => isSignIn = !isSignIn);

  @override
  Widget build(BuildContext context) {
    return isSignIn ? SignInPage(toggle: toggle) : RegisterPage(toggle: toggle);
  }
}
