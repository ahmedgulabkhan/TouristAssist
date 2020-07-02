import 'package:TouristAssist/pages/selectusertype_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TouristAssist',
      home: SelectUserTypePage()
    );
  }
}
