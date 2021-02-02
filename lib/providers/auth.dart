import 'dart:async';
import 'package:dextraquario/helper/constants.dart';
import 'package:dextraquario/models/user_model.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  User _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();

  UserModel _userModel;
  GoogleSignIn _googleSignIn = GoogleSignIn();

//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;

  AuthProvider.init() {
    _fireSetUp();
  }

  _fireSetUp() async {
    await initialization.then((value) {
      auth.authStateChanges().listen(_onStateChanged);
    });
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(credential).then((userCredentials) async {
        _user = userCredentials.user;
        var userInfo = userCredentials.additionalUserInfo;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("id", _user.uid);
        if (!await _userServices.doesUserExist(_user.uid) &&
            _user.email.endsWith("@dextra-sw.com")) {
          _userServices.createUser(
            id: _user.uid,
            name: _user.displayName,
            photo: _user.photoURL,
          );
          await initializeUserModel();
        } else {
          await initializeUserModel();
        }
      });

      if (_user.email.endsWith("@dextra-sw.com")) {
        return {'success': true, 'message': 'success'};
      } else {
        return {'success': false, 'message': 'not dextra email'};
      }
    } catch (e) {
      notifyListeners();
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<bool> initializeUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _userId = preferences.getString('id');
    _userModel = await _userServices.getUserById(_userId);
    notifyListeners();
    if (_userModel == null) {
      return false;
    } else {
      return true;
    }
  }

  Future signOut() async {
    await auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
  }

  _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
      notifyListeners();
    } else {
      if (firebaseUser.email.endsWith("@dextra-sw.com")) {
        initializeUserModel();
        _status = Status.Authenticated;
        notifyListeners();
      } else {
        _status = Status.Unauthenticated;
      }
    }
  }
}
