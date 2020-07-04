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
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _getLocationDetails();
  }

  _getLocationDetails() async {
    final location = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _touristLocation = location;
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return _isLoading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('TouristAssist'),
        elevation: 0.0,
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
    );
  }
}