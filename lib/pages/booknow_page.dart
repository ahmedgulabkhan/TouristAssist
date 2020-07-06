import 'package:TouristAssist/pages/guide_details_page.dart';
import 'package:TouristAssist/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookNowPage extends StatelessWidget {

  final String currentUserCity;
  BookNowPage({
    this.currentUserCity
  });

  Future<List> _getGuidesInfo() async {
    QuerySnapshot snapshot = await Firestore.instance.collection('guides').where('city', isEqualTo: currentUserCity).getDocuments();

    return snapshot.documents;
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Guides near you', style: TextStyle(color: Colors.white)),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        )
      ),
      body: FutureBuilder(
        future: _getGuidesInfo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.data == null) {
            return LoadingAlt();
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.blue,
                    child: Text(snapshot.data[index]['fullName'].substring(0,1).toUpperCase(), style: TextStyle(color: Colors.white)),
                  ),
                  title: Text(snapshot.data[index]['fullName'], style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  subtitle: Text('4⭐ • Rs. ${snapshot.data[index]['costPerHour']}/hr'),
                  trailing: FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      _makePhoneCall('tel:${snapshot.data[index]['phoneNumber']}');
                    },
                    child: Text('Call now', style: TextStyle(color: Colors.white))
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GuideDetailsPage(guideUid: snapshot.data[index]['uid'])));
                  },
                );
              }
            );        
          }
        }
      )
    );
  }
}