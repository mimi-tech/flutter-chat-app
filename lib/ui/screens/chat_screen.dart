import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:site/colors/colors.dart';
import 'package:site/dimens/dimens.dart';
import 'package:site/ui/widgets/chatConstant.dart';
import 'package:site/ui/widgets/site_variable.dart';
final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
class ChatScreen extends StatefulWidget {
  ChatScreen({@required this.docList});

  final List<DocumentSnapshot> docList;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  static var now = new DateTime.now();
  var date = new DateFormat("yyyy-MM-dd hh:mm:ss").format(now);
  String messageText;
  @override
  void initState() {
    super.initState();
    getCurrentuserProfile();
  }
  void getCurrentuserProfile() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        loggedInUser.uid;
      }else{
        Navigator.pushNamed(context, '/signin');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality

              }),
        ],
        title: Text('⚡️ ${widget.docList[0]['fn']}'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({'tx':messageText,
                        'se':loggedInUser.email,
                        'uid':loggedInUser.uid,'cid':widget.docList[0]['uid'],
                        'na':widget.docList[0]['fn'],'ph':widget.docList[0]['ph'],'dt':date,'cna': widget.docList[0]['fn']});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class MessagesStream extends StatefulWidget {
  @override
  _MessagesStreamState createState() => _MessagesStreamState();
}

class _MessagesStreamState extends State<MessagesStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('messages').where('uid',isEqualTo: loggedInUser.uid).snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];
        for(var message in messages){
          final messageText = message.data['tx'];
          final messageSender = message.data['se'];
          final messageuid = message.data['uid'];
          final messagecid = message.data['cid'];
          final messagename = message.data['na'];
          final messagecname = message.data['cna'];
          final messageph = message.data['ph'];
          final messagedate = message.data['dt'];
          final currentUser = loggedInUser.email;


          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            uid:messageuid,
            cid:messagecid,
            name:messagename,
            cname:messagecname,
            ph:messageph,
            date:messagedate,
            isMe: currentUser == messageSender,);
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:EdgeInsets.symmetric(horizontal:10, vertical:20),
            children: messageBubbles,
          ),
        );

      },
    );
  }
}


class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text,this.isMe,this.uid,this.cid,this.name,this.ph,this.date,this.cname});
  final String sender;
  final String text;
  final bool isMe;
  final String cname;
  final String uid;
  final String cid;
  final String name;
  final String ph;
  final String date;
  @override
  Widget build(BuildContext context) {

    return
      Padding(
        padding:EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[

            if(isMe)  Column(
              crossAxisAlignment:  CrossAxisAlignment.end,
              children: <Widget>[
                Text(name + " " + date ,
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
                Material(
                  borderRadius:  BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0)) ,


                  elevation: 5.0,
                  color: Colors.lightBlueAccent,

                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(text,
                        style:TextStyle(
                          fontSize: ScreenUtil()
                              .setSp(
                              kFontsize,
                              allowFontScalingSelf:
                              true),
                          fontWeight:
                          FontWeight.bold,
                          fontFamily: 'RobotoSlab',
                          color: kWhitemain,
                        )),
                  ),
                ),
              ],
            ),

            StreamBuilder(
                stream: _firestore.collection('messages').where('cid',isEqualTo: loggedInUser.uid).snapshots(),
                builder: (context, snapshot) {
                  List<DocumentSnapshot> workingDocument = snapshot.data.documents;

                  if (workingDocument.length == 0) {
                    return Text('');
                  } else {
                    return ListView.builder(
                    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: workingDocument.length,
    itemBuilder: (context, int index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${workingDocument[index]['name']} ${workingDocument[index]['date']}',
              style: TextStyle(
                fontSize: ScreenUtil()
                    .setSp(
                    kFontsize,
                    allowFontScalingSelf:
                    true),
                fontWeight:
                FontWeight.bold,
                fontFamily: 'RobotoSlab',
                color: Colors.black38,
              )),
          Material(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),


            elevation: 5.0,
            color: Colors.lightGreen,

            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(workingDocument[index]['text'] == null?'':workingDocument[index]['text'],
                  style: TextStyle(
                    fontSize: ScreenUtil()
                        .setSp(
                        kFontsize,
                        allowFontScalingSelf:
                        true),
                    fontWeight:
                    FontWeight.bold,
                    fontFamily: 'RobotoSlab',
                    color: kWhitemain,
                  )),
            ),
          ),
        ],
      );
    }
                    );

                  }
                })

          ],
        ),
      );
  }
}

