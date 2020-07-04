import 'package:TouristAssist/helper/helper_functions.dart';
import 'package:TouristAssist/pages/guide_home_page.dart';
import 'package:TouristAssist/pages/selectusertype_page.dart';
import 'package:TouristAssist/pages/tourist_home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedIn;
  String _userType;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getIsLoggedIn();
  }

  _getIsLoggedIn() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((result) {
      setState(() {
        _isLoggedIn = result;
      });
    });

    await HelperFunctions.getUserTypeSharedPreference().then((result) {
      setState(() {
        _userType = result;
      });
    });

    setState(() {
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return _isLoading ? Container(color: Colors.black87) : MaterialApp(
      title: 'TouristAssist',
      debugShowCheckedModeBanner: false,
      // home: SelectUserTypePage()
      home: _isLoggedIn ? (_userType == 'Tourist' ? TouristHomePage() : GuideHomePage()) : SelectUserTypePage()
    );
  }
}
