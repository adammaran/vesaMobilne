import 'package:flutter/material.dart';
import 'package:turisticka_agencija/repository/UserRepository.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        padding: EdgeInsets.only(top: 80, left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.center,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "email",
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Šifra",
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      UserRepository userRepo = UserRepository();
                      userRepo.loginUser(emailController.text,
                          passwordController.text, context);
                    },
                    child: Text("Uloguj se"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
