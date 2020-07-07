import 'package:TouristAssist/helper/helper_functions.dart';
import 'package:TouristAssist/pages/change_name_page.dart';
import 'package:TouristAssist/pages/change_password_page.dart';
import 'package:TouristAssist/pages/selectusertype_page.dart';
import 'package:TouristAssist/services/database_service.dart';
import 'package:TouristAssist/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  FirebaseUser user;
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  _getUserDetails() async {
    user = await FirebaseAuth.instance.currentUser();
    await HelperFunctions.getUserNameSharedPreference().then((value) {
      setState(() {
        userName = value;
      });
    });
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        userEmail = value;
      });
    });
    await HelperFunctions.getUserPasswordSharedPreference().then((value) {
      setState(() {
        userPassword = value;
      });
    });

    setState(() {
      _isLoading = false;
    });
  }

  _deleteAccount() async {
    setState(() {
      _isLoading = true;
    });

    await DatabaseService(uid: user.uid).deleteUser();
    user.delete();

    await HelperFunctions.saveUserLoggedInSharedPreference(false);
    await HelperFunctions.saveUserEmailSharedPreference('');
    await HelperFunctions.saveUserNameSharedPreference('');
    await HelperFunctions.saveUserPasswordSharedPreference('');

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SelectUserTypePage()), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? LoadingAlt() : Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(
          color: Colors.white
        )
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangeNamePage(userUid: user.uid)));
            },
            title: Text('Name'),
            subtitle: Text(userName),
            trailing: Text('Change Name'),
          ),
          Divider(),
          ListTile(
            onTap: () {

            },
            title: Text('Email'),
            subtitle: Text(userEmail),
          ),
          Divider(),
          ListTile(
            onTap: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePasswordPage(userUid: user.uid)));
            },
            title: Text('Password'),
            trailing: Text('Change Password'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              _deleteAccount();
            },
            title: Text('Delete account', style: TextStyle(color: Colors.red)),
          )
        ],
      )
    );
  }
}