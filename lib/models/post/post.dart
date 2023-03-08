import 'package:blood_donation/models/donor/donor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String blood;
  final int units;
  final String location;
  final Donor donor;
  final Timestamp from;

  Post(this.blood, this.units, this.location, this.donor, this.from);
}
