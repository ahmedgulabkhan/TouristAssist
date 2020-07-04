import 'package:TouristAssist/pages/tourist_signin_page.dart';
import 'package:TouristAssist/pages/tourist_signup_page.dart';
import 'package:flutter/material.dart';

class TouristAuthenticatePage extends StatefulWidget {

  @override
  _TouristAuthenticatePageState createState() => _TouristAuthenticatePageState();
}

class _TouristAuthenticatePageState extends State<TouristAuthenticatePage> {
  
  bool showSignIn = false;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn) {
      return TouristSignInPage(toggleView: toggleView);
    }
    else {
      return TouristSignUpPage(toggleView: toggleView);
    }
  }
}