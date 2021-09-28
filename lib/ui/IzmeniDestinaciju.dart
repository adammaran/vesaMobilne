import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turisticka_agencija/models/Destinacija.dart';
import 'package:turisticka_agencija/repository/DestinacijaRepository.dart';

class EditDestinationScreen extends StatelessWidget {
  final Destination destination;

  EditDestinationScreen({required this.destination});

  @override
  Widget build(BuildContext context) {
    TextEditingController destination = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController description = TextEditingController();

    destination.text = this.destination.destination;
    price.text = this.destination.price.toString();
    description.text = this.destination.description;
    return Scaffold(
      appBar: AppBar(title: Text('Izmeni destinaciju')),
      body: Container(
        padding: EdgeInsets.only(top: 240, left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.center,
              controller: destination,
              decoration: InputDecoration(hintText: 'Destinacija'),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'cena'),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: description,
              decoration: InputDecoration(hintText: 'Opis'),
            ),
            ElevatedButton(
                onPressed: () {
                  DestinationRepository paymentRepo =
                      DestinationRepository(context: context);
                  paymentRepo.editDestById(destination.text, price.text,
                      description.text, this.destination.id);
                },
                child: Text('Izmeni'))
          ],
        ),
      ),
    );
  }
}
