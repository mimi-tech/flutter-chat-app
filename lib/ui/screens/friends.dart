import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:site/dimens/dimens.dart';
import 'package:site/ui/screens/chat_screen.dart';
import 'package:site/ui/screens/sign_in.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);

    return SafeArea(child: Scaffold(
        appBar: AppBar(
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  //Implement logout functionality

                }),
          ],
          title: Row(
            children: [
              Text('⚡️Simple Chat App'),

              IconButton(icon: Icon(Icons.logout,color: Colors.yellow,), onPressed: (){
                _auth.signOut();
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: SignInScreen()));

              })
            ],


          ),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Container(
      child: StreamBuilder( stream: _firestore.collection('users')
        .snapshots(),
    builder: (context, snapshot) {
      List<DocumentSnapshot> workingDocument = snapshot.data.documents;

      if (workingDocument.length == 0) {
return  Center(
  child:   Text('Sorry you have no friends yet',
      style:TextStyle(
        fontSize: ScreenUtil()
            .setSp(
            kFontsize,
            allowFontScalingSelf:
            true),
        fontWeight:
        FontWeight.bold,
        fontFamily: 'RobotoSlab',
        color: Colors.black54,
      )),
);
      }else{
        return  ListView.builder(
        physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: workingDocument.length,
    itemBuilder: (context, int index) {
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: (){
          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChatScreen(docList:workingDocument)));

        }
        ,
        leading: CircleAvatar(
          //backgroundColor: Colors.transparent,
            radius: 30.0,
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                //placeholder: kTransparentImage,
                placeholder: 'assets/images/default.png',
                image:workingDocument[index]['pp'],
                fit: BoxFit.cover,
                width: 50.0,
                height: 50.0,
              ),

            )
        ),
        title: Text(workingDocument[index]['fn'],
            style:TextStyle(
              fontSize: ScreenUtil()
                  .setSp(
                  kFontsize,
                  allowFontScalingSelf:
                  true),
              fontWeight:
              FontWeight.bold,
              fontFamily: 'RobotoSlab',
              color: Colors.black54,
            )),

        subtitle: Text(workingDocument[index]['ln'],
            style:TextStyle(
              fontSize: ScreenUtil()
                  .setSp(
                  kFontsize,
                  allowFontScalingSelf:
                  true),
              fontWeight:
              FontWeight.bold,
              fontFamily: 'RobotoSlab',
              color: Colors.black54,
            )),
      ),
    );

        });
      }


    }
    )
    )
    ));
  }
}
