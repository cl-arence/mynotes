import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  
const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

@override
  dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
              children: [
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  enableSuggestions: false,
                ),
            
                TextField(
                  controller: _password,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                ),
            
                TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;

                    try {
                      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                      Navigator.of(context).pushNamed(verifyEmailRoute);
                      devtools.log(userCredential.toString());
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        await showErrorDialog(context, 'The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        await showErrorDialog(context, 'The account already exists for that email.');
                      } else if (e.code == 'invalid-email') {
                        await showErrorDialog(context, 'The email is invalid.');
                      } else {
                        await showErrorDialog(context, 'Error: ${e.code}');
                      }
                    } catch (e) {
                      await showErrorDialog(context, e.toString(),);
                    }
                  },
                  child: const Text('Register'),
                ),
                TextButton(
                  onPressed: () {Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);},
                  child: const Text('Already registered? Login here!'),
                ),
              ],
            ),
    );
  }
}

