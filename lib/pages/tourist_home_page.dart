import 'package:TouristAssist/helper/helper_functions.dart';
import 'package:TouristAssist/pages/booknow_page.dart';
import 'package:TouristAssist/pages/guide_details_page.dart';
import 'package:TouristAssist/pages/selectusertype_page.dart';
import 'package:TouristAssist/pages/settings_page.dart';
import 'package:TouristAssist/services/auth_service.dart';
import 'package:TouristAssist/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class TouristHomePage extends StatefulWidget {

  @override
  _TouristHomePageState createState() => _TouristHomePageState();
}

class _TouristHomePageState extends State<TouristHomePage> {

  bool _isLoading = true;
  dynamic _touristLocation;
  dynamic _currentUserCity;
  String _userName = '';
  List<dynamic> _guides;
  final AuthService _authService = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getUserAndLocationDetails();
  }

  _getUserAndLocationDetails() async {
    await HelperFunctions.getUserNameSharedPreference().then((value) {
      setState(() {
        _userName = value;
      });
    });
    final location = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<Placemark> p = await Geolocator().placemarkFromCoordinates(location.latitude, location.longitude);
    Placemark place = p[0];

    setState(() {
      _touristLocation = location;
      _currentUserCity = place.locality.toLowerCase();
      _isLoading = false;
    });

    QuerySnapshot snapshot = await Firestore.instance.collection('guides').where('city', isEqualTo: _currentUserCity).getDocuments();
    _guides = snapshot.documents;
  }

  List<Marker> _getGuideMarkers() {
    List<Marker> _markers = [
      Marker(
        height: 45.0,
        width: 45.0,
        point: LatLng(_touristLocation.latitude, _touristLocation.longitude),
        builder: (context) => Container(
          child: IconButton(
            icon: Icon(Icons.location_on),
            color: Colors.red,
            iconSize: 45.0,
            onPressed: () {}
          ),
        )
      ),
    ];

    if(_guides != null) {
      for(dynamic item in _guides ) {
        _markers.add(
          Marker(
            height: 30.0,
            width: 30.0,
            point: LatLng(item['latitude'], item['longitude']),
            builder: (context) => Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GuideDetailsPage(guideUid: item['uid'])));
                },
                child: Text('📍', style: TextStyle(fontSize: 30.0))
              ),
            )
          )
        );
      }
    }

    return _markers;
  }
  
  @override
  Widget build(BuildContext context) {
    return _isLoading ? Loading() : Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          iconSize: 35.0,
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: (){
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                height: 150.0,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                color: Theme.of(context).backgroundColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.account_circle, color: Colors.white, size: 60.0),
                    SizedBox(width: 10.0),
                    Text(_userName, style: TextStyle(color: Colors.white, fontSize: 18.0))
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.home),
                title: Text('Home', style: TextStyle(fontSize: 16.0)),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.settings),
                title: Text('Settings', style: TextStyle(fontSize: 16.0)),
              ),
              ListTile(
                onTap: () async {
                  await _authService.signOut();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SelectUserTypePage()), (Route<dynamic> route) => false);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                title: Text('Sign Out', style: TextStyle(fontSize: 16.0, color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(_touristLocation.latitude, _touristLocation.longitude),
          minZoom: 5.0
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
          ),
          MarkerLayerOptions(
            markers: _getGuideMarkers()
          )
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookNowPage(currentUserCity: _currentUserCity)));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 65.0,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text('Book a Guide Now', style: TextStyle(color: Colors.white, fontSize: 20.0))
          )
        ),
      ),
    );
  }
}