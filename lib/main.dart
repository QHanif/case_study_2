import 'dart:io';

import 'package:case_study_2/widgettree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:case_study_2/pages/loginscreen.dart';
import 'package:case_study_2/pages/registerscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          appId: '1:195063921079:android:a034ddc9d23f4275e0d032',
          messagingSenderId: '195063921079',
          projectId: 'fir-cs2',
          apiKey: 'AIzaSyDAWq2sokNaM10ZUEAT91yNDQILA3pUa5Y',
        ))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      // initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WidgetTree(),
    );
  }
}
