import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  int phoneNumber;
  String password;

  verifyPhoneNumber(String number) {
    FirebaseAuth mAuth = FirebaseAuth.instance;

    String response;
    mAuth.verifyPhoneNumber(
        phoneNumber: '+91' + number,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) async {
          AuthResult authResult =
              await mAuth.signInWithCredential(authCredential);
          FirebaseUser user = authResult.user;
          if (user != null) {
            response = 'AutoVerified';
          }
        },
        verificationFailed: (AuthException authException) {
          print(authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          Map codeSentResponse = {
            'verificationId': verificationId,
            'forceResendingToken': forceResendingToken
          };
          print('Manual verification');
          // return codeSentResponse;
        },
        codeAutoRetrievalTimeout: null);
    print('Response = ' + response);
  }

  Future<FirebaseUser> get getCurrentUser async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print('User = ' + user.email);
    return user;
  }
}
