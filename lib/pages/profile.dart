import 'package:blood_donation/models/donor/donor_doc.dart';
import 'package:blood_donation/models/user.dart';
import 'package:blood_donation/services/firestore.dart';
import 'package:blood_donation/shared/decorations.dart';
import 'package:blood_donation/shared/widgets/loading.dart';
import 'package:blood_donation/shared/widgets/profile_tile.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DBUser>(context);

    return StreamBuilder<DonorDoc>(
        stream: FirestoreService(uid: user.uid).donorDoc,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (snapshot.hasData) {
            DonorDoc? donor = snapshot.data;

            return Container(
              decoration: linearDecoration,
              child: loading
                  ? const Center(
                      child: Loading(),
                    )
                  : Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        title: const Text("PROFILE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3.5)),
                        centerTitle: true,
                        elevation: 0.0,
                        actions: [
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              await FirestoreService().addUnits(user.uid);
                              setState(() {
                                loading = false;
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        leading: IconButton(
                          onPressed: () {
                            if (!mounted) {
                              return;
                            }
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.chevron_left_rounded,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 28.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              donor!.blood,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 180.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3.0,
                                  fontFamily: "sans-serif-condensed",
                                  color: Colors.white60),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ProfileTile(
                                        text: donor.name,
                                        icon: Icons.text_fields_rounded),
                                    ProfileTile(
                                        text: donor.gender,
                                        icon: Icons.male_rounded),
                                    ProfileTile(
                                        text: donor.dob,
                                        icon: Icons.cake_rounded),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ProfileTile(
                                        text: donor.blood,
                                        icon: Icons.water_drop_rounded),
                                    ProfileTile(
                                        text: donor.units.toString(),
                                        icon: Icons.numbers_rounded),
                                    ProfileTile(
                                        text: donor.location,
                                        icon: Icons.location_on_rounded),
                                  ],
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.alternate_email_rounded,
                                      size: 28.0,
                                      color: Colors.black87,
                                    ),
                                    const SizedBox(
                                      width: 12.0,
                                    ),
                                    Text(
                                      donor.email.toLowerCase(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black87,
                                          letterSpacing: 4.0),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
            );
          } else {
            return const Center(
              child: Loading(),
            );
          }
        });
  }
}
