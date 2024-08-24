import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Image.network(
                'https://img.freepik.com/free-photo/bank-card-mobile-phone-online-payment_107791-16646.jpg'),
            formField(emailController, 'Email'),
            SizedBox(height: 10),
            formField(passwordController, 'Password'),
            SizedBox(height: 10),
            isLoading
                ? CircularProgressIndicator() 
                : ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        login(emailController, passwordController, context);
                      }
                    },
                    child: const Text('Sign In'),
                  ),
          ],
        ),
      ),
    );
  }

  Widget formField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        validator: (value) {
          if ((value ?? '').isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()),
        controller: controller,
      ),
    );
  }

  Future<void> login(TextEditingController emailController,
      TextEditingController passwordController, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
     
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false; 
      });
    }
  }
}
