import 'package:blood_donation/models/donor/donor.dart';
import 'package:blood_donation/models/donor/donor_doc.dart';
import 'package:blood_donation/models/post/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final String? uid;

  FirestoreService({this.uid});

  final CollectionReference _donors =
      FirebaseFirestore.instance.collection("donors");

  final CollectionReference _posts =
      FirebaseFirestore.instance.collection("posts");

  DonorDoc _extractDonorFromFirestore(DocumentSnapshot snapshot) {
    return DonorDoc(
        uid!,
        (snapshot.data() as Map<String, dynamic>)["name"],
        (snapshot.data() as Map<String, dynamic>)["dob"],
        (snapshot.data() as Map<String, dynamic>)["blood"],
        (snapshot.data() as Map<String, dynamic>)["units"].toInt(),
        (snapshot.data() as Map<String, dynamic>)["gender"],
        (snapshot.data() as Map<String, dynamic>)["location"],
        (snapshot.data() as Map<String, dynamic>)["email"]);
  }

  List<Post> _extractPostsList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Post(
          (doc.data() as Map<String, dynamic>)["blood"],
          (doc.data() as Map<String, dynamic>)["units"],
          (doc.data() as Map<String, dynamic>)["location"],
          Donor(
              (doc.data() as Map<String, dynamic>)["donor"]["name"],
              (doc.data() as Map<String, dynamic>)["donor"]["dob"],
              (doc.data() as Map<String, dynamic>)["donor"]["blood"],
              (doc.data() as Map<String, dynamic>)["donor"]["units"],
              (doc.data() as Map<String, dynamic>)["donor"]["gender"],
              (doc.data() as Map<String, dynamic>)["donor"]["location"],
              (doc.data() as Map<String, dynamic>)["donor"]["email"]),
          (doc.data() as Map<String, dynamic>)["from"]);
    }).toList();
  }

  Stream<DonorDoc> get donorDoc {
    return _donors.doc(uid).snapshots().map(_extractDonorFromFirestore);
  }

  Stream<List<Post>> get posts {
    return _posts.snapshots().map(_extractPostsList);
  }

  Stream<List<Post>> filteredPosts(String search) {
    final Query filtered = _posts.where("location", isEqualTo: search);
    return filtered.snapshots().map(_extractPostsList);
  }

  Future updateUser(Donor donor) async {
    try {
      return await _donors.doc(uid).set({
        "name": donor.name,
        "dob": donor.dob,
        "blood": donor.blood,
        "units": donor.units,
        "gender": donor.gender,
        "location": donor.location,
        "email": donor.email
      });
    } catch (e) {
      return null;
    }
  }

  Future addPost(Post post) async {
    try {
      return await _posts.add({
        "blood": post.blood,
        "units": post.units,
        "location": post.location,
        "donor": post.donor.toMap(),
        "from": post.from
      });
    } catch (e) {
      return null;
    }
  }

  Future getDonorByID(String id) async {
    return _donors.doc(id).get();
  }

  Future addUnits(String id) async {
    return _donors.doc(id).update({"units": FieldValue.increment(1)});
  }
}
