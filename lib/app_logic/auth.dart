import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:personal_expenses/model/user_profile.dart';

class Auth {
  GoogleSignIn _googleSignIn;
  FirebaseAuth _firebaseAuth;
  FacebookLogin _facebookLogin;
  FirebaseApp _app;
  static const String SUCCESS_MSG = 'SUCCESS';
  static final Auth instance = Auth._instance();

  Auth._instance();

  Future<FirebaseApp> initAuth() async {
    _app = await Firebase.initializeApp();
    _googleSignIn = GoogleSignIn();
    _facebookLogin = FacebookLogin();
    _firebaseAuth = FirebaseAuth.instance;
    return _app;
  }

  Future<UserProfile> facebookSignIn() async {
    try {
      FacebookLoginResult result = await _facebookLogin.logIn(['email']);
      if (result.status == FacebookLoginStatus.loggedIn) {
        http.Response graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,email&access_token=${result.accessToken.token}',
        );
        var profile = json.decode(graphResponse.body);
        UserProfile user = UserProfile.fromJson(json.decode(graphResponse.body),
            'http://graph.facebook.com/${profile['id']}/picture?type=large');
        return user;
      } else if (result.status == FacebookLoginStatus.cancelledByUser) {
      } else if (result.status == FacebookLoginStatus.error) {
      }
    } catch (e) {
    }
  }

  Future<List<String>> verifyEmail(String email) async {
    List<String> listOfEmailMethods =
        await _firebaseAuth.fetchSignInMethodsForEmail(email);
    return listOfEmailMethods;
  }

  Future<String> createNewUser(String email, String password,
      {String displayName, String photoUrl}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user
          .updateProfile(displayName: displayName, photoURL: photoUrl);
      return SUCCESS_MSG;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  User get currentUser => _firebaseAuth.currentUser;

  Future<String> loginAccount(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return SUCCESS_MSG;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> forgetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return SUCCESS_MSG;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> updateProfile({String displayName, String photoUrl}) async {
    try {
      await _firebaseAuth.currentUser
          .updateProfile(displayName: displayName, photoURL: photoUrl);
      return SUCCESS_MSG;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<UserProfile> googleSignIn() async {
    GoogleSignInAccount auth = await _googleSignIn.signIn();
    UserProfile user = UserProfile.fromSocial(auth);
    return user;
  }

  Future<String> firebaseSignOut() async {
    try {
      await _firebaseAuth.signOut();
      return SUCCESS_MSG;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
