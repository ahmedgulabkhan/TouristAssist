import 'package:TouristAssist/pages/selectusertype_page.dart';
import 'package:TouristAssist/services/auth_service.dart';
import 'package:flutter/material.dart';

class GuideHomePage extends StatelessWidget {

  final AuthService _authService = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('TouristAssist'),
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              await _authService.signOut();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SelectUserTypePage()), (Route<dynamic> route) => false);
            },
            child: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(
        child: Text('This is the guide homepage'),
      ),
    );
  }
}