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
    return _isLoading ? LoadingAlt() : Scaffold(
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
                Text.rich(
                  TextSpan(
                    text: "Name: ",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: '${_guideData['fullName']}', style: TextStyle(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),

                Divider(height: 30.0),

                Text.rich(
                  TextSpan(
                    text: "City: ",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: '${capitalize(_guideData['city'].toString())}', style: TextStyle(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),

                Divider(height: 30.0),

                Text.rich(
                  TextSpan(
                    text: "Rating: ",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: '${_guideData['rating']}⭐', style: TextStyle(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),

                Divider(height: 30.0),

                Text.rich(
                  TextSpan(
                    text: "Cost: ",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: 'Rs. ${_guideData['costPerHour']}/hr', style: TextStyle(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
              ],
            )            
          ),
        ],
      ),
      bottomSheet: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _makePhoneCall('tel:${_guideData['phoneNumber']}');
            },
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              height: 65.0,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text('Call now', style: TextStyle(color: Colors.white, fontSize: 18.0))
              )
            ),
          ),

          GestureDetector(
            onTap: () {
              
            },
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              height: 65.0,
              color: Colors.green,
              child: Center(
                child: Text('Rate this Guide', style: TextStyle(color: Colors.white, fontSize: 18.0))
              )
            ),
          ),
        ],
      ),
    );
  }
}