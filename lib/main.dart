import 'package:blood_donation/firebase_options.dart';
import 'package:blood_donation/models/user.dart';
import 'package:blood_donation/pages/wrapper.dart';
import 'package:blood_donation/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<DBUser?>.value(
      initialData: null,
      value: AuthService().donor,
      catchError: (context, error) => null,
      lazy: true,
      child: MaterialApp(
          title: "Blood Donation",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.red, fontFamily: "Comfortaa"),
          home: const Wrapper()),
    );
  }
}
