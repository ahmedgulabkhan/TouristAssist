import 'package:TouristAssist/services/database_service.dart';
import 'package:TouristAssist/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GuideDetailsPage extends StatefulWidget {

  final String guideUid;
  GuideDetailsPage({
    this.guideUid
  });

  @override
  _GuideDetailsPageState createState() => _GuideDetailsPageState();
}

class _GuideDetailsPageState extends State<GuideDetailsPage> {

  dynamic _guideData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getGuideDetails();
  }

  _getGuideDetails() async {
    _guideData = await DatabaseService().getGuideData(widget.guideUid);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Loading() : Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2 - 100,
            child: Icon(Icons.person, color: Colors.white, size: MediaQuery.of(context).size.height/2 - 100),
            color: Colors.black87,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Name: ${_guideData['fullName']}', style: TextStyle(fontSize: 16.0)),
                Divider(height: 30.0),
                Text('City: ${capitalize(_guideData['city'].toString())}', style: TextStyle(fontSize: 16.0)),
                Divider(height: 30.0),
                Text('Rating: ${_guideData['rating']}⭐', style: TextStyle(fontSize: 16.0)),
                Divider(height: 30.0),
                Text('Cost: Rs. ${_guideData['costPerHour']}/hr', style: TextStyle(fontSize: 16.0)),
                Divider(height: 30.0),
              ],
            )            
          ),
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          _makePhoneCall('tel:${_guideData['phoneNumber']}');
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 65.0,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text('Call now', style: TextStyle(color: Colors.white, fontSize: 20.0))
          )
        ),
      ),
    );
  }
}