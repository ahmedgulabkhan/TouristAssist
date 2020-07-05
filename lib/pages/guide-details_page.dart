import 'package:flutter/material.dart';

class GuideDetailsPage extends StatelessWidget {

  final String guideUid;
  GuideDetailsPage({
    this.guideUid
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        )
      ),
      body: Center(
        child: Text('The uid is: $guideUid'),
      ),
    );
  }
}