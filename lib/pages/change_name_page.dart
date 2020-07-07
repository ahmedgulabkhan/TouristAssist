import 'package:TouristAssist/helper/helper_functions.dart';
import 'package:TouristAssist/pages/tourist_home_page.dart';
import 'package:TouristAssist/services/database_service.dart';
import 'package:TouristAssist/shared/constants.dart';
import 'package:TouristAssist/shared/loading.dart';
import 'package:flutter/material.dart';

class ChangeNamePage extends StatefulWidget {

  final String userUid;
  ChangeNamePage({
    this.userUid
  });

  @override
  _ChangeNamePageState createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameEditingController = new TextEditingController();

  void _changeName(BuildContext context, String newName) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await DatabaseService(uid: widget.userUid).changeName(newName);
      await HelperFunctions.saveUserNameSharedPreference(newName);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => TouristHomePage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? LoadingAlt() : Scaffold(
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
                  _changeName(context, _nameEditingController.text);
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