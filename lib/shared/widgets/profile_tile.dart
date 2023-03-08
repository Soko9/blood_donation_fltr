import "package:flutter/material.dart";

class ProfileTile extends StatelessWidget {
  const ProfileTile({Key? key, required this.text, required this.icon})
      : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      width: 120.0,
      height: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            size: 32.0,
            color: Colors.black87,
          ),
          Text(
            text,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 14.0,
                letterSpacing: 1.0,
                color: Colors.red[300],
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
