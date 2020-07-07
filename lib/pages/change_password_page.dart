import 'package:TouristAssist/shared/constants.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordEditingController = new TextEditingController();

  // also make sure to change the sharedpreferences

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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