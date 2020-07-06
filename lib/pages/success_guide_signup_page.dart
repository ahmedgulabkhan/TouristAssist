import 'package:flutter/material.dart';

class SuccessGuideSignUpPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        // leading: ,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            CircleAvatar(
              radius: 65.0,
              backgroundColor: Colors.green,
              child: Icon(Icons.done, color: Colors.white, size: 80.0),
            ),
            // Icon(Icons.done_outline, color: Colors.green, size: 100.0),
            SizedBox(height: 30.0),
            Text('You have successfully been registered as a guide. You will now recieve calls when a tourist wants to hire you', style: TextStyle(fontSize: 18.0, color: Colors.white))
          ]
        ),
      ),
    );
  }
}