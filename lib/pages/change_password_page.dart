import 'package:TouristAssist/helper/helper_functions.dart';
import 'package:TouristAssist/pages/tourist_home_page.dart';
import 'package:TouristAssist/services/database_service.dart';
import 'package:TouristAssist/shared/constants.dart';
import 'package:TouristAssist/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {

  final String userUid;
  ChangePasswordPage({
    this.userUid
  });

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordEditingController = new TextEditingController();

  void _changePassword(BuildContext context, String newPassword) async{
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      user.updatePassword(newPassword).then((_){
        print("Succesfull changed password");
      }).catchError((error){
        print("Password can't be changed" + error.toString());
      });

      await DatabaseService(uid: widget.userUid).changePassword(newPassword);
      await HelperFunctions.saveUserPasswordSharedPreference(newPassword);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => TouristHomePage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? LoadingAlt() : Scaffold(
      appBar: AppBar(
        title: Text('Change password'),
        elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _passwordEditingController,
                decoration: textInputDecoration.copyWith(
                  hintText: 'Enter new password',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.lock, color: Colors.black)
                ),
                validator: (val) => val.length < 6 ? 'Password not strong enough' : null,
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              FlatButton(
                color: Colors.green,
                onPressed: () {
                  _changePassword(context, _passwordEditingController.text);
                },
                child: Text('Change password', style: TextStyle(color: Colors.white))
              )
            ],
          ),
        ),
      ),
    );
  }
}