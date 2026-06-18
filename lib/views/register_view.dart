import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

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

      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, asyncSnapshot) {
          
          switch (asyncSnapshot.connectionState) {
            case ConnectionState.done:
              return Column(
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
          
              TextButton(onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                
                try{
                  final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  print(userCredential);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    } else {
                      print(e.code);
                    }
                }
                },
                child: const Text('Register')
              ),
          
            ],
          );
            default:
              return const Text('Loading...');
          }
          
        }
      )
    );
  }
}

