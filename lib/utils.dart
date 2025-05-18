import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pamphere/blocs/sign_in_bloc/sign_in_bloc.dart';

class Utils {
  // reuse inside a widget class since a parameter [BuildContext context] is required
  // example: Utils.showLogoutDialog(context);
  static void showLogoutDialog(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                context.read<SignInBloc>().add(SignOutRequired());
              },
              child: Text('Logout'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<SignInBloc>().add(SignOutRequired());
              },
            ),
          ],
        ),
      );
    }
  }

  static Future<bool> googleSignIn() async {
    final user = await GoogleSignIn().signIn();

    GoogleSignInAuthentication userAuth = await user!.authentication;

    var credential = GoogleAuthProvider.credential(
      accessToken: userAuth.accessToken,
      idToken: userAuth.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential);

    return FirebaseAuth.instance.currentUser != null;
  }
}
