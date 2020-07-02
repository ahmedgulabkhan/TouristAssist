import 'package:TouristAssist/pages/authenticate_page.dart';
import 'package:flutter/material.dart';

class SelectUserTypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('TravelAssist 🚀', style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),

            SizedBox(height: 50.0),

            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthenticatePage()));
              },
              child: Text('Get started as a Tourist', style: TextStyle(color: Colors.white, fontSize: 18.0)),
              color: Colors.lightBlueAccent,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            ),

            SizedBox(height: 20.0),

            FlatButton(
              onPressed: () {},
              child: Text('Get started as a Guide', style: TextStyle(color: Colors.white, fontSize: 18.0)),
              color: Colors.lightBlueAccent,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}