import 'package:blood_donation/shared/constants.dart';
import "package:flutter/material.dart";

final inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.only(left: 12.0),
    filled: true,
    fillColor: Colors.red[100],
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide(color: Colors.red[200]!, width: 2.0)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide(color: Colors.red[300]!, width: 2.0)));

const inputStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.black87,
  letterSpacing: 2.0,
);

const linearDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [secondColor, bgColor],
    end: Alignment.bottomCenter,
    begin: Alignment.topCenter,
  ),
);
