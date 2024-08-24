import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/sign_up.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                logOut().then((_) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ));
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text('Welcome'),
      ),
    );
  }
}

Future<void> logOut() async {
  await FirebaseAuth.instance.signOut();
}
