import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turisticka_agencija/ui/sveDestinacijeStranica.dart';

class UserRepository {
  final _databaseReference = FirebaseFirestore.instance;

  void loginUser(email, password, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AllDestinationsScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        final snackBar = SnackBar(content: Text('Korisnik nije pronadjen'));
        Scaffold.of(context).showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        final snackBar = SnackBar(content: Text('Pogrešna šifra'));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    }
  }
}
