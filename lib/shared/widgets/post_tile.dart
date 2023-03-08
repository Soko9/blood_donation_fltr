import 'package:blood_donation/models/post/post.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  const PostTile({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30.0,
                    child: Center(
                      child: Text(
                        post.blood.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.5,
                            color: Colors.white,
                            fontSize: 22.0),
                      ),
                    )),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                    post.units > 1
                        ? "${post.units} UNITS"
                        : "${post.units} UNIT",
                    style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_city_rounded,
                      size: 20.0,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      post.location.toString(),
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black87,
                          letterSpacing: 1.5),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18.0,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.watch_later,
                      size: 20.0,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      post.from.toDate().toLocal().toString().substring(0, 16),
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black87,
                          letterSpacing: 1.5),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18.0,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.person_rounded,
                      size: 20.0,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      "By ${post.donor.name}",
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black87,
                          letterSpacing: 1.5),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
