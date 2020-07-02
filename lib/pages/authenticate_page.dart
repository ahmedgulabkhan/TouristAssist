import 'package:TouristAssist/pages/signin_page.dart';
import 'package:TouristAssist/pages/signup_page.dart';
import 'package:flutter/material.dart';

class AuthenticatePage extends StatefulWidget {

  @override
  _AuthenticatePageState createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  
  bool showSignIn = false;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn) {
      return SignInPage(toggleView: toggleView);
    }
    else {
      return SignUpPage(toggleView: toggleView);
    }
  }
}