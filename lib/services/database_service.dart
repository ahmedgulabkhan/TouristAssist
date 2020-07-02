import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({
    this.uid
  });

  // Collection reference
  final CollectionReference touristCollection = Firestore.instance.collection('tourists');
  final CollectionReference guideCollection = Firestore.instance.collection('guides');

  // update userdata
  Future updateUserData(String fullName, String email, String password) async {
    return await touristCollection.document(uid).setData({
      'fullName': fullName,
      'email': email,
      'password': password,
      'groups': [],
      'profilePic': ''
    });
  }

  // get user data
  Future getTouristData(String email) async {
    QuerySnapshot snapshot = await touristCollection.where('email', isEqualTo: email).getDocuments();
    // print(snapshot.documents[0].data);
    return snapshot;
  }
}