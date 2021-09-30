import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turisticka_agencija/models/Destinacija.dart';
import 'package:turisticka_agencija/repository/DestinacijaRepository.dart';
import 'package:turisticka_agencija/ui/DodajDestinaciju.dart';
import 'package:turisticka_agencija/ui/IzmeniDestinaciju.dart';
import 'package:turisticka_agencija/ui/loginStranica.dart';

class AllDestinationsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AllDestinationsState();
}

class AllDestinationsState extends State<AllDestinationsScreen> {
  @override
  Widget build(BuildContext context) {
    DestinationRepository destRepo = DestinationRepository(context: context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Prikaz svih letova"),
        actions: [
          SizedBox(width: 18),
          if (FirebaseAuth.instance.currentUser == null)
            GestureDetector(
              child: Icon(Icons.login),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          else if (FirebaseAuth.instance.currentUser!.uid ==
              "WCPFxihK26QDV6R43ImaGQLc8Gp2")
            GestureDetector(
              child: Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
                setState(() {});
              },
            )
          else
            Container()
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: destRepo.getDestinationList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
            if (snap.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snap.data.length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            child: Row(
                              children: [
                                Text("Destinacija: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(snap.data.elementAt(index).destination),
                                SizedBox(width: 12),
                                Text("Cena",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(snap.data.elementAt(index).price.toString())
                              ],
                            ),
                          ),
                          FirebaseAuth.instance.currentUser != null ?
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditDestinationScreen(
                                                      destination: snap.data
                                                          .elementAt(index))));
                                    },
                                    child: Text("Izmeni")),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        destRepo.deleteDestById(
                                            snap.data.elementAt(index).id);
                                      });
                                    },
                                    child: Text("Obriši"))
                              ],
                            ),
                          ) : Container()
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FirebaseAuth.instance.currentUser != null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddDestinationScreen()));
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
