import 'package:TouristAssist/pages/success_guide_signup_page.dart';
import 'package:TouristAssist/services/auth_service.dart';
import 'package:TouristAssist/shared/constants.dart';
import 'package:TouristAssist/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GuideSignUpPage extends StatefulWidget {

  @override
  _GuideSignUpPageState createState() => _GuideSignUpPageState();
}

class _GuideSignUpPageState extends State<GuideSignUpPage> {

  TextEditingController _fullNameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _phoneNumberEditingController = new TextEditingController();
  TextEditingController _cityEditingController = new TextEditingController();
  TextEditingController _costPerHourEditingController = new TextEditingController();
  TextEditingController _passwordEditingController = new TextEditingController();
  TextEditingController _confirmPasswordEditingController = new TextEditingController();

  final AuthService _authService = new AuthService();

  final _formKey = GlobalKey<FormState>();
  dynamic _guideLocation = '';
  bool _isLoading = false;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    final location = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _guideLocation = location;
    });
  }

  _onRegister() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      await _authService.registerGuideWithEmailAndPassword(_fullNameEditingController.text, _emailEditingController.text, _phoneNumberEditingController.text, _cityEditingController.text.toLowerCase(), _costPerHourEditingController.text, _passwordEditingController.text, _guideLocation.latitude, _guideLocation.longitude).then((result) async {
        if (result != null) {
          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SuccessGuideSignUpPage()), (Route<dynamic> route) => false);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SuccessGuideSignUpPage()));
        }
        else {
          setState(() {
            _error = 'Error while registering the user!';
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Loading() : Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 80.0),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Get started as a Guide", style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),
                    
                  SizedBox(height: 30.0),
                    
                  Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    
                  SizedBox(height: 20.0),
                    
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _fullNameEditingController,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Full Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person, color: Colors.white)
                    ),
                    validator: (val) => val.isEmpty ? 'This field cannot be blank' : null
                  ),
                    
                  SizedBox(height: 15.0),
                    
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _emailEditingController,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.alternate_email, color: Colors.white)
                    ),
                    validator: (val) {
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Please enter a valid email";
                    },
                  ),

                  SizedBox(height: 15.0),
                    
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _phoneNumberEditingController,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.phone, color: Colors.white)
                    ),
                    validator: (val) => val.isEmpty ? 'This field cannot be blank' : null
                  ),

                  SizedBox(height: 15.0),
                    
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _cityEditingController,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Current City',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.location_on, color: Colors.white)
                    ),
                    validator: (val) => val.isEmpty ? 'This field cannot be blank' : null
                  ),

                  SizedBox(height: 15.0),
                    
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _costPerHourEditingController,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Cost per hour (Rs.)',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.attach_money, color: Colors.white)
                    ),
                    validator: (val) => val.isEmpty ? 'This field cannot be blank' : null
                  ),
                    
                  SizedBox(height: 15.0),
                    
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _passwordEditingController,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.lock, color: Colors.white)
                    ),
                    validator: (val) => val.length < 6 ? 'Password not strong enough' : null,
                    obscureText: true,
                  ),

                  SizedBox(height: 15.0),
                    
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _confirmPasswordEditingController,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Confirm password',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                    ),
                    validator: (val) => val == _passwordEditingController.text ? null : 'Does not macth the password',
                    obscureText: true,
                  ),

                  SizedBox(height: 10.0),

                  Text('Your current location will be used for signing up', style: TextStyle(color: Colors.white)),

                  _guideLocation == '' ? Text('') :
                  Text('Lat: ${_guideLocation.latitude.toStringAsFixed(3)}, Long: ${_guideLocation.longitude.toStringAsFixed(3)}', style: TextStyle(color: Colors.white)),

                  SizedBox(height: 20.0),
                    
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                      elevation: 0.0,
                      color: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      child: Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                      onPressed: () {
                        _onRegister();
                      }
                    ),
                  ),

                  SizedBox(height: 10.0),
                    
                  Text(_error, style: TextStyle(color: Colors.red, fontSize: 14.0)),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}