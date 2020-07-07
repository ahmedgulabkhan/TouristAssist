import 'package:TouristAssist/shared/constants.dart';
import 'package:flutter/material.dart';

class ChangeNamePage extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change name', style: TextStyle(color: Colors.white)),
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
                controller: _nameEditingController,
                decoration: textInputDecoration.copyWith(
                  hintText: 'Enter new name',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.person, color: Colors.black),
                ),
                validator: (val) => val.isEmpty ? 'This field cannot be blank' : null
              ),
              SizedBox(height: 10.0),
              FlatButton(
                color: Colors.green,
                onPressed: () {

                },
                child: Text('Change name', style: TextStyle(color: Colors.white))
              )
            ],
          ),
        ),
      ),
    );
  }
}