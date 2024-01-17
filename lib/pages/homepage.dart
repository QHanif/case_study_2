import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:case_study_2/auth.dart';

class HomePage extends StatelessWidget{
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> _signOut() async {
    await Auth().signOut();
  }

  Widget _title(){
    return Text('Firebase Auth');
  }

  Widget _userUid(){
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton(){
    return ElevatedButton(
      onPressed: _signOut,
      child: Text('Sign Out'),
    );
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar:AppBar(

      ),
      body:Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            _userUid(),
            _signOutButton(),
          ]
        )
      )
    );
  }
}