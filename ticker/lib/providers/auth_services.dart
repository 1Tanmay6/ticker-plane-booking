import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/BottomNavBar.dart';

class AuthServices with ChangeNotifier {
  String _uid = '';

  User? user;

  String get uid => _uid;

  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? gauth = await guser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gauth!.accessToken,
      idToken: gauth.idToken,
    );
    final res = await FirebaseAuth.instance.signInWithCredential(credential);

    user = res.user;
    _uid = res.user!.uid;
    print(user);

    if (_uid != '') {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return BottomNavBar();
          },
        ),
      );
    }
    return res;
  }
}
