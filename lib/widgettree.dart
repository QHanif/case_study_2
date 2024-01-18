//saufi

import 'package:case_study_2/auth.dart';
import 'package:case_study_2/pages/homepage.dart';
// import 'package:case_study_2/pages/loginregister.dart';
import 'package:flutter/material.dart';
import 'package:case_study_2/pages/loginscreen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
