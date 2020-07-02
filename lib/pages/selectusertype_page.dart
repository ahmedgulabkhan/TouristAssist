import 'package:TouristAssist/pages/authenticate_page.dart';
import 'package:flutter/material.dart';

class SelectUserTypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('TravelAssist', style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold)),

            SizedBox(height: 30.0),

            FlatButton(
              onPressed: () {

              },
              child: Text('Get started as a Guide', style: TextStyle(color: Colors.white)),
              color: Colors.blueAccent,
            ),

            SizedBox(height: 15.0),

            FlatButton(
              onPressed: () {
                AuthenticatePage();
              },
              child: Text('Get started as a Tourist', style: TextStyle(color: Colors.white)),
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}