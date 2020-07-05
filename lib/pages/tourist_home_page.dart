import 'package:TouristAssist/pages/booknow_page.dart';
import 'package:TouristAssist/pages/selectusertype_page.dart';
import 'package:TouristAssist/services/auth_service.dart';
import 'package:TouristAssist/shared/loading.dart';
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
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _getLocationDetails();
  }

  _getLocationDetails() async {
    final location = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<Placemark> p = await Geolocator().placemarkFromCoordinates(location.latitude, location.longitude);
    Placemark place = p[0];

    setState(() {
      _touristLocation = location;
      _currentUserCity = place.locality.toLowerCase();
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return _isLoading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('TouristAssist', style: TextStyle(color: Colors.white)),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              await _authService.signOut();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SelectUserTypePage()), (Route<dynamic> route) => false);
            },
            child: Icon(Icons.exit_to_app),
          )
        ],
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
            markers: [
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
              )
            ]
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
          // onPressed: () {
          //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookNowPage()));
          // },
          child: Center(
            child: Text('Book a Guide Now', style: TextStyle(color: Colors.white, fontSize: 20.0))
          )
        ),
      ),
    );
  }
}