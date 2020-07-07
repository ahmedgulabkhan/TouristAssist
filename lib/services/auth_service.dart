import 'package:TouristAssist/helper/helper_functions.dart';
import 'package:TouristAssist/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return (user != null) ? User(uid: user.uid) : null;
  }


  // sign in tourist with email and password
  Future signInTouristWithEmailAndPassword(String email, String password) async {
    bool isWrongLogin = await DatabaseService().isGuideSigningIn(email);
    if(isWrongLogin) {
      return null;
    }
    else {
      try {
        AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return _userFromFirebaseUser(user);
      } catch(e) {
        print(e.toString());
        return null;
      }
    }
  }


  // register tourist with email and password
  Future registerTouristWithEmailAndPassword(String fullName, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // Create a new document for the user with uid
      await DatabaseService(uid: user.uid).updateTouristData(fullName, email, password);
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  // sign in guide with email and password
  Future signInGuideWithEmailAndPassword(String email, String password) async {
    bool isWrongLogin = await DatabaseService().isTouristSigningIn(email);
    if(isWrongLogin) {
      return null;
    }
    else {
      try {
        AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return _userFromFirebaseUser(user);
      } catch(e) {
        print(e.toString());
        return null;
      }
    }
  }


  // register guide with email and password
  Future registerGuideWithEmailAndPassword(String fullName, String email, String phoneNumber, String city, String costPerHour, String password, double latitude, double longitude) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // Create a new document for the user with uid
      await DatabaseService(uid: user.uid).updateGuideData(fullName, email, phoneNumber, city, costPerHour, password, latitude, longitude);
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  //sign out
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInSharedPreference(false);
      await HelperFunctions.saveUserEmailSharedPreference('');
      await HelperFunctions.saveUserNameSharedPreference('');

      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}