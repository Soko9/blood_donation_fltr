import 'package:blood_donation/shared/constants.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitThreeBounce(
      size: 50.0,
      color: secondColor,
    );
  }
}
