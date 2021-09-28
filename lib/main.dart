import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:turisticka_agencija/ui/loginStranica.dart';
import 'package:turisticka_agencija/ui/sveDestinacijeStranica.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turistička Agencija',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AllDestinationsScreen(),
    );
  }
}
