import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';
import '../util/validate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Validator validator = Validator();
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'invalid-credential':
            errorMessage = 'Invalid email/password entered. Please try again.';
            break;
          default:
            errorMessage =
                'An unknown error occurred with error code: ${e.code}.';
        }
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage =
                'The account already exists for that email. Login instead.';
            break;
          default:
            errorMessage =
                'An unknown error occurred with error code: ${e.code}.';
        }
      });
    }
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _entryField(String title, TextEditingController controller,
      String? Function(String?)? validator,
      {bool isPassword = false}) {
    bool obscureText = isPassword;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            labelText: title,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : null,
          ),
        );
      },
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage',
        style: const TextStyle(color: Colors.red));
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // No validation errors. It's safe to proceed.
          if (isLogin) {
            signInWithEmailAndPassword();
          } else {
            createUserWithEmailAndPassword();
          }
        }
      },
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register' : 'Login Instead'),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _title(),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _entryField('Email', _controllerEmail, validator.validateEmail),
                _entryField(
                    'Password', _controllerPassword, validator.validatePassword,
                    isPassword: true),
                _errorMessage(),
                _submitButton(),
                _loginOrRegisterButton(),
              ],
            ),
          ),
        ));
  }
}
