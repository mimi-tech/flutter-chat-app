import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:site/ui/screens/friends.dart';
import 'package:site/ui/screens/sign_in.dart';
import 'package:site/ui/widgets/site_variable.dart';
class CurrentUsers extends StatefulWidget {
  @override
  _CurrentUsersState createState() => _CurrentUsersState();
}

class _CurrentUsersState extends State<CurrentUsers> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentuser();
  }

  getCurrentuser() async {
    try {
     final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        Variables.Lu = user.toString();
        Variables.loggedInUseremail = loggedInUser.email;
        Variables.loggedInUseruid = loggedInUser.uid;

        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: FriendsScreen()));
      } else {
        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SignInScreen()));
      }
    } catch (e) {

    }
  }
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .where('em', isEqualTo: Variables.loggedInUseremail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            Variables.firstNameupdates = '${snapshot.data.documents[0]['fn']}';
            Variables.lastNameupdates = '${snapshot.data.documents[0]['ln']}';
            Variables.phoneupdates = '${snapshot.data.documents[0]['ph']}';
            Variables.usernameupdates = '${snapshot.data.documents[0]['un']}';
            Variables.emailupdates = '${snapshot.data.documents[0]['em']}';
            Variables.profilePictureupdates = '${snapshot.data.documents[0]['pp']}';

            return Text('');
          }
        });
  }
}
