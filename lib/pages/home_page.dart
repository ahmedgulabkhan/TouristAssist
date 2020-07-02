import 'package:TouristAssist/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('TouristAssist'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              _authService.signOut();
            },
            child: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(
        child: Text('This is the homepage'),
      ),
    );
  }
}