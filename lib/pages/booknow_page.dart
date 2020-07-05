import 'package:flutter/material.dart';

class BookNowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Guides near you', style: TextStyle(color: Colors.white)),
        elevation: 0.0,
      ),
      body: Center(
        child: Text('This is the booking guides page'),
      ),
    );
  }
}