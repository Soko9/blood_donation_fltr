import 'package:blood_donation/models/donor/donor.dart';
import 'package:blood_donation/models/user.dart';
import 'package:blood_donation/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DBUser _extractUserFromFirebase(UserCredential user) {
    return DBUser(uid: user.user!.uid);
  }

  DBUser _extractUserFromStream(User? user) {
    return DBUser(uid: user!.uid);
  }

  // onAuthChange
  Stream<DBUser> get donor {
    return _auth.authStateChanges().map(_extractUserFromStream);
  }

  // Register
  Future registerDonor(String email, String password, Donor donor) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirestoreService(uid: user.user?.uid).updateUser(donor);
      return _extractUserFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return "Unknown error";
    }
  }

  // Sign in
  Future signInDonor(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _extractUserFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return "Unknown error...";
    }
  }

  // Sign out
  Future<void> signOutDonor() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
