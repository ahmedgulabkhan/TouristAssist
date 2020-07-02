import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {

  final Function toggleView;
  SignUpPage({this.toggleView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is the sign up page'),
      ),
    );
  }
}