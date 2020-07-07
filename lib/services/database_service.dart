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
  Future updateGuideData(String fullName, String email, String phoneNumber, String city, String costPerHour, String password, double latitude, double longitude) async {
    return await guideCollection.document(uid).setData({
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'city': city,
      'costPerHour': costPerHour,
      'rating': 0,
      'votes': [],
      'latitude': latitude,
      'longitude': longitude
    });
  }

  // get user data
  Future getTouristData(String email) async {
    QuerySnapshot snapshot = await touristCollection.where('email', isEqualTo: email).getDocuments();
    // print(snapshot.documents[0].data);
    return snapshot;
  }

  // get guide data
  Future getGuideData(String uid) async {
    QuerySnapshot snapshot = await guideCollection.where('uid', isEqualTo: uid).getDocuments();
    return snapshot.documents[0].data;
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

  // submit rating
  submitRating(int starNum, String userUid) async {
    DocumentSnapshot guideDocSnapshot = await guideCollection.document(uid).get();
    await guideCollection.document(uid).updateData({
      'rating': ((guideDocSnapshot.data['rating'] * guideDocSnapshot.data['votes'].length) + starNum) / (guideDocSnapshot.data['votes'].length + 1),
      'votes': FieldValue.arrayUnion([userUid])
    });
  }

  // update name
  changeName(String newName) async {
    return await touristCollection.document(uid).updateData({
      'fullName': newName
    });
  }

  // update name
  changePassword(String newPassword) async {
    return await touristCollection.document(uid).updateData({
      'password': newPassword
    });
  }

  // delete user account
  deleteUser() async {
    return await touristCollection.document(uid).delete();
  }
}