import 'package:TouristAssist/helper/helper_functions.dart';
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

  bool _isLoggedIn = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getIsLoggedIn();
  }

  _getIsLoggedIn() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((result) {
      if(result != null) {
        setState(() {
          _isLoggedIn = result;
        });
      }
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
      theme: ThemeData(
        primaryColor: Colors.blue,
        backgroundColor: Colors.black87,
      ),
      // home: SelectUserTypePage()
      home: _isLoggedIn ? TouristHomePage() : SelectUserTypePage()
    );
  }
}
