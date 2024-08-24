import 'package:flutter/material.dart';
import 'package:flutter_application_1/sign_in.dart';
import 'package:flutter_application_1/sign_up.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SignUp(),
      ),
    );
  }
}
