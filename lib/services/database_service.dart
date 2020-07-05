import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({
    this.uid
  });

  // Collection reference
  final CollectionReference touristCollection = Firestore.instance.collection('tourists');
  final CollectionReference guideCollection = Firestore.instance.collection('guides');

  // update tourist data
  Future updateTouristData(String fullName, String email, String password) async {
    return await touristCollection.document(uid).setData({
      'fullName': fullName,
      'email': email,
      'password': password,
    });
  }

  // update guide data
  Future updateGuideData(String fullName, String email, String phoneNumber, String city, String costPerHour, String password) async {
    return await guideCollection.document(uid).setData({
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'city': city,
      'costPerHour': costPerHour
    });
  }

  // get user data
  Future getTouristData(String email) async {
    QuerySnapshot snapshot = await touristCollection.where('email', isEqualTo: email).getDocuments();
    // print(snapshot.documents[0].data);
    return snapshot;
  }

  // is guide attempting to sign in as a tourist
  Future<bool> isGuideSigningIn(String email) async {
    QuerySnapshot snapshot = await guideCollection.where('email', isEqualTo: email).getDocuments();
    if(snapshot.documents.length == 0) {
      return false;
    }
    else return true;
  }

  // is tourist attempting to sign in as a guide
  Future<bool> isTouristSigningIn(String email) async {
    QuerySnapshot snapshot = await touristCollection.where('email', isEqualTo: email).getDocuments();
    if(snapshot.documents.length == 0) {
      return false;
    }
    else return true;
  }
}