import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/sign_in.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Image.network(
                'https://img.freepik.com/free-photo/bank-card-mobile-phone-online-payment_107791-16646.jpg'),
            formFaild(emailController, 'email'),
            SizedBox(
              height: 10,
            ),
            formFaild(passwordController, 'password'),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    signUp(emailController, passwordController, context);
                  }
                },
                child: Text('sign Up')),
            TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ));
                },
                label: Text('Sini in'))
          ],
        ),
      ),
    );
  }
}

Widget formFaild(controller, lable) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: TextFormField(
      validator: (value) {
        if ((value ?? '').toString().isEmpty) {
          return 'blease enter ${lable}';
        } else
          return null;
      },
      decoration:
          InputDecoration(labelText: lable, border: OutlineInputBorder()),
      controller: controller,
    ),
  );
}

Future<void> signUp(emailController, passwordController, context) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignIn(),
    ));
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'weak-password') {
      message = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      message = 'The account already exists for that email.';
    } else {
      message = 'An error occurred. Please try again.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('An unexpected error occurred.')));
  }
}
