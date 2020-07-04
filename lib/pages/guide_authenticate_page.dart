import 'package:TouristAssist/pages/guide_signin_page.dart';
import 'package:TouristAssist/pages/guide_signup_page.dart';
import 'package:flutter/material.dart';

class GuideAuthenticatePage extends StatefulWidget {

  @override
  _GuideAuthenticatePageState createState() => _GuideAuthenticatePageState();
}

class _GuideAuthenticatePageState extends State<GuideAuthenticatePage> {
  
  bool showSignIn = false;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn) {
      return GuideSignInPage(toggleView: toggleView);
    }
    else {
      return GuideSignUpPage(toggleView: toggleView);
    }
  }
}