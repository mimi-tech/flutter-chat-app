
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:site/colors/colors.dart';
import 'package:site/dimens/dimens.dart';

import 'package:site/strings/strings.dart';
import 'package:site/ui/screens/friends.dart';

import 'package:site/ui/screens/sign_in.dart';

import 'package:site/ui/widgets/component_signup.dart';

import 'package:site/util/Constants.dart';
import 'package:site/util/auth.dart';
import 'package:site/util/state_widget.dart';
import 'package:site/util/validator.dart';

import 'package:firebase_auth/firebase_auth.dart';



class SignUpScreen extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _phone = new TextEditingController();
  final TextEditingController _username = new TextEditingController();


  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  bool _autoValidate = false;

  File imageURI;
bool _postModal = false;
  Future getImageFromCamera() async {

    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageURI = image;

    });
  }

  StorageUploadTask uploadTask;
  String filePath = 'userprofilepictures/${DateTime.now()}.png';

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {

    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);

    final firstName = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _firstName,
      validator: Validator.validateName,
      style: TextStyle(
        color: (kGrey),
        fontFamily: 'RobotoSlab',
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil()
            .setSp(kFontsize, allowFontScalingSelf: true),
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: kGrey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: kFirstnamehint,

      ),
    );
    final username = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _username,
      validator: Validator.validateusername,
      style: TextStyle(
        color: (kGrey),
        fontFamily: 'RobotoSlab',
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil()
            .setSp(kFontsize, allowFontScalingSelf: true),
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: kGrey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: kUsernametext,

      ),
    );
    final lastName = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _lastName,
      validator: Validator.validateName,
      style: TextStyle(
        color: (kGrey),
        fontFamily: 'RobotoSlab',
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil()
            .setSp(kFontsize, allowFontScalingSelf: true),
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: kGrey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: kLastnamehint,
        //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _email,
      validator: Validator.validateEmail,
      style: TextStyle(
        color: (kGrey),
        fontFamily: 'RobotoSlab',
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil()
            .setSp(kFontsize, allowFontScalingSelf: true),
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.email,
            color: kGrey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: kEmailhint,
        //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _password,
      validator: Validator.validatePassword,
      style: TextStyle(
        color: (kGrey),
        fontFamily: 'RobotoSlab',
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil()
            .setSp(kFontsize, allowFontScalingSelf: true),
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.lock,
            color: kGrey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: kPasswordhint,
        //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );


    final phone = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      controller: _phone,
      validator: Validator.validateNumber,
      style: TextStyle(
        color: (kGrey),
        fontFamily: 'RobotoSlab',
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil()
            .setSp(kFontsize, allowFontScalingSelf: true),
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.phone,
            color: kGrey
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: kPhonenumberhint,
        //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final profilePictureText = Align(
      alignment: Alignment.topLeft,
      child: Container(

          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0,),
          child: Column(

            children: <Widget>[
              Text(kProfilePicturehint,
                  style: TextStyle(
                    color: (kGrey),
                    fontFamily: 'RobotoSlab',
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil()
                        .setSp(kFontsize, allowFontScalingSelf: true),
                  ),),
            ],
          )

      ),
    );


    final profilePicture = Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0,),

      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[

            if (imageURI == null) InkWell(

              onTap: getImageFromCamera,

              child: Container(
                child: CircleAvatar(
                  backgroundColor:kGrey,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/default.png',
                      fit: BoxFit.cover,
                      width: 60.0,
                      height: 60.0,
                    ),

                  ),
                ),
              ),

            ) else
              Column(
                children: <Widget>[
                  Container(

                    child: CircleAvatar(
                      
                      child: ClipOval(
                        child: InkWell(
                          onTap: getImageFromCamera,
                          child: Image.file(imageURI, width: 45.0,
                            height: 44.0,
                           
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),

          ],
        ),
      ),

    );
    final line = Container(height:2.0,
        color:kLinecolor);




    final signUpButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onPressed: () {
          _emailSignUp(
              firstName: _firstName.text,
              userName: _username.text,
              lastName: _lastName.text,
              email: _email.text,
              password: _password.text,
              phone: _phone.text,
              context: context);
        },
        padding: EdgeInsets.all(12),
        color:kMainbrowncolor,
        child: Text(kSignup , style: TextStyle(
          color: (kGrey),
          fontFamily: 'RobotoSlab',
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil()
              .setSp(kFontsize, allowFontScalingSelf: true),
        ),),
      ),
    );

    final signInLabel = FlatButton(
      child: RichText(
    text: TextSpan(
    text: Kquestion,
        style: TextStyle(
          color: (kGrey),
          fontFamily: 'RobotoSlab',
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil()
              .setSp(kFontsize, allowFontScalingSelf: true),
        ),
    children: <TextSpan>[
    TextSpan(text: kSignin,
      style: TextStyle(
        color: (kGrey),
        fontFamily: 'RobotoSlab',
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil()
            .setSp(kFontsize, allowFontScalingSelf: true),
      ),
    recognizer: TapGestureRecognizer(),

    )
      ]
      ),

    ),
        onPressed: () {
     // Navigator.pushNamed(context, '/signin');
          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SignInScreen()));
    },
    );
    return SafeArea(
      child: Scaffold(

        backgroundColor: kMainbrowncolor,
        body: ModalProgressHUD(
        inAsyncCall: _postModal,
            child: Column(

              children: <Widget>[
                HeaderRegister(title:'SignUp',welcome: 'Welcome'),
                Form(
                  key: _formKey,
                 autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Expanded(
                    flex:6,
                    child: Container(
                      decoration: new BoxDecoration(
                          color:kLightbrown,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[

                                firstName,
                                SizedBox(height: 24.0),
                                lastName,
                                SizedBox(height: 24.0),
                                username,
                                SizedBox(height: 24.0),
                                email,
                                SizedBox(height: 24.0),
                                password,
                                SizedBox(height: 24.0),
                                phone,
                                SizedBox(height: 12.0),
                                profilePictureText,
                                SizedBox(height: 12.0),
                                profilePicture,
                                SizedBox(height: 12.0),
                                 line,
                                signUpButton,
                                signInLabel
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

      ),
      )
    );
  }



  void _emailSignUp(
      {String firstName,
        String userName,
        String lastName,
        String email,
        String password,
        String phone,

        //String imageURI,
        BuildContext context}) async {
    if (_formKey.currentState.validate()) {

      if( imageURI != null) {
        try {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          setState(() {
            _postModal = true;
          });

          final QuerySnapshot result =
          await Firestore.instance.collection('users')
              .where('un', isEqualTo: userName)
              .getDocuments();

          final List <DocumentSnapshot> documents = result.documents;

          if (documents.length == 1) {
            setState(() {
              _postModal = false;
            });
            Fluttertoast.showToast(
                msg: 'UserName Already exist',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: kBlackcolor,
                textColor: kRedColor);

          } else {
            final newUser = await _auth.createUserWithEmailAndPassword(
                email: email, password: password);
            if (newUser != null) {
              StorageReference ref =
              FirebaseStorage.instance.ref().child(filePath).child("image.jpg");
              uploadTask = ref.putFile(imageURI);
              StorageMetadata(
                contentType: "images" + '/' + "jpg",
              );
              final StorageTaskSnapshot downloadUrl =
              (await uploadTask.onComplete);
              final String url = (await downloadUrl.ref.getDownloadURL());
              print('URL Is $url');

              FirebaseUser currentUser = await FirebaseAuth.instance
                  .currentUser();
              //await sparksUserCollection.document(loggedInUserID).setData({
              _firestore.collection("users").add({
                'uid': currentUser.uid,
                'fn': firstName,
                'un': userName,
                'ln': lastName,
                'em': email,
                'ph': phone,
                'pp': url,

              });

              setState(() {
                _postModal = false;
              });

              Fluttertoast.showToast(
                  msg: 'Sign up successfully',
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: kBlackcolor,
                  textColor: kGreenColor);

              Navigator.of(context).pushReplacement
                (MaterialPageRoute(builder: (context) => FriendsScreen()));
            }
          }

          //now automatically login user too
          //await StateWidget.of(context).logInUser(email, password);

        } catch (e) {
          setState(() {
            _postModal = false;
          });

          print("Sign Up Error: $e");
          String exception = Auth.getExceptionText(e);
          Fluttertoast.showToast(
              msg: 'Sign up error',
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: kBlackcolor,
              textColor: kRedColor);

        }
      }else{

        Fluttertoast.showToast(
            msg: 'Sign up',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: kBlackcolor,
            textColor: kRedColor);

      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
  void choiceAction(String choice){
    if(choice == Constants.fund){
      print('fund');
    }else if(choice == Constants.SignOut){
      StateWidget.of(context).logOutUser();
      Fluttertoast.showToast(
          msg: 'Signed out successfully',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: kBlackcolor,
          textColor: kGreenColor);

    }
  }
}
