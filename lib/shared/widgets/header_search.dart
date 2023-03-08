import 'package:blood_donation/shared/decorations.dart';
import "package:flutter/material.dart";

class HeaderSearch extends StatefulWidget {
  const HeaderSearch({Key? key, required this.search}) : super(key: key);

  final String search;

  @override
  State<HeaderSearch> createState() => _HeaderSearchState();
}

class _HeaderSearchState extends State<HeaderSearch> {
  @override
  Widget build(BuildContext context) {
    String srch = widget.search;

    return Container();
  }
}
