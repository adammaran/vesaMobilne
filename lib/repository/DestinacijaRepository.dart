import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turisticka_agencija/models/Destinacija.dart';
import 'package:turisticka_agencija/ui/sveDestinacijeStranica.dart';

class DestinationRepository {
  BuildContext context;

  DestinationRepository({required this.context});

  final _databaseReference = FirebaseFirestore.instance;

  void addDestination(destination, price, description) async {
    _databaseReference.collection('destinations').add({
      'destination': destination,
      'price': price,
      'description': description
    }).then((value) {
      _databaseReference
          .collection('destinations')
          .doc(value.id)
          .update({'id': value.id});
    }).then((value) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AllDestinationsScreen()));
    });
  }

  Future<List<Destination>> getDestinationList() async {
    List<Destination> destinationList = [];
    QuerySnapshot doc =
        await _databaseReference.collection('destinations').get();
    //Probaj umesto mapiranja ovde da samo posaljes ceo Query snap pa u UI da se drkas sa vadjnjem podataka :)
    doc.docs.forEach((element) {
      destinationList.add(Destination.create(
          id: element.get('id'),
          destination: element.get('destination'),
          price: int.parse(element.get('price')),
          description: element.get('description')));
    });
    return destinationList;
  }

  void deleteDestById(id) async {
    _databaseReference.collection('destinations').doc(id).delete();
  }

  void editDestById(destination, price, description, id) async {
    print(id);
    _databaseReference.collection('destinations').doc(id).update({
      'destination': description,
      'price': price,
      'description': description
    }).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AllDestinationsScreen()));
    });
  }
}
