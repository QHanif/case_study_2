import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';
import '../util/validate.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Validator validator = Validator();
  String? errorMessage = '';
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  bool _isHiddenPassword = true;

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        username: _controllerUsername.text,
      );
      // Registration successful, show a dialog
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Registration Successful'),
            content: const Text('Click OK to go to the Homepage screen.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(); // Close the register screen
                },
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
              TextFormField(
                controller: _controllerUsername,
                validator: validator.validateDisplayName,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _controllerEmail,
                validator: validator.validateEmail,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _controllerPassword,
                obscureText: _isHiddenPassword,
                validator: validator.validatePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffix: InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(
                      _isHiddenPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _controllerConfirmPassword,
                obscureText: _isHiddenPassword,
                // validator: validator.validateRepeatPassword(value, _controllerPassword),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffix: InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(
                      _isHiddenPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              Text(errorMessage == '' ? '' : 'Hmm ? $errorMessage',
                  style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createUserWithEmailAndPassword();
                  }
                },
                child: const Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Register'),
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _controllerEmail,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),
//             TextField(
//               controller: _controllerPassword,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//               ),
//             ),
//             Text(errorMessage == '' ? '' : 'Hmm ? $errorMessage'),
//             ElevatedButton(
//               onPressed: createUserWithEmailAndPassword,
//               child: Text('Register'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Go back to Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
}
