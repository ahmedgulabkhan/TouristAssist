import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(
          color: Colors.white
        )
      ),
      body: Center(
        child: Text('This is the settings page')
      ),
    );
  }
}