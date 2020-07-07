import 'package:TouristAssist/pages/change_name_page.dart';
import 'package:TouristAssist/pages/change_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {

  final String userName;
  final String userPassword;
  final String userEmail;

  SettingsPage({
    this.userName,
    this.userEmail,
    this.userPassword
  });


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
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangeNamePage()));
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
            trailing: Text('Change Email'),
          ),
          Divider(),
          ListTile(
            onTap: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePasswordPage()));
            },
            title: Text('Password'),
            trailing: Text('Change Password'),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            title: Text('Delete account', style: TextStyle(color: Colors.red)),
          )
        ],
      )
    );
  }
}