import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:site/ui/screens/friends.dart';

import 'package:site/ui/screens/sign_in.dart';

import 'package:site/ui/widgets/site_variable.dart';

class HomeController extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
          if (snapshot.hasData){
            FirebaseUser user = snapshot.data; // this is your user instance
            /// is because there is user already logged
            if (user != null) {

              Variables.loggedInUser = user;
              //Variables.emails = Variables.loggedInUser.email;
            }
              return FriendsScreen();
          }
          /// other way there is no user logged in.
          return SignInScreen();
        }
    );
  }
}
