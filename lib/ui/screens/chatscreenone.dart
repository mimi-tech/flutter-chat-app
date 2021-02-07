import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:site/ui/screens/friends.dart';
import 'package:site/ui/screens/sign_in.dart';
import 'package:site/ui/widgets/site_variable.dart';
class GetCurrentUserDetails extends StatefulWidget {
  @override
  _GetCurrentUserDetailsState createState() => _GetCurrentUserDetailsState();
}

class _GetCurrentUserDetailsState extends State<GetCurrentUserDetails> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentuser();
  }
  void getCurrentuser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: FriendsScreen()));

      }else{
        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SignInScreen()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: Firestore.instance
        .collection('users')
        .where('em', isEqualTo: loggedInUser.email)
        .snapshots(),
    builder: (context, snapshot) {
      Variables.profilePictureCopy =
      '${snapshot.data.documents[0]['pp']}';
      Variables.lfn =
      '${snapshot.data.documents[0]['fn']}';
      if (!snapshot.hasData) {
        return Text('');
      }
      return Text('');
    }
    );

  }
}
