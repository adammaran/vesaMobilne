import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turisticka_agencija/repository/DestinacijaRepository.dart';

class AddDestinationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController destination = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController description = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Nova destinacija')),
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
                  paymentRepo.addDestination(
                      destination.text, price.text, description.text);
                },
                child: Text('Dodaj'))
          ],
        ),
      ),
    );
  }
}
