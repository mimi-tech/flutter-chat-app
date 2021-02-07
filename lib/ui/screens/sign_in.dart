import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:site/colors/colors.dart';
import 'package:site/dimens/dimens.dart';
import 'package:site/strings/strings.dart';
import 'package:site/ui/screens/friends.dart';
import 'package:site/ui/widgets/compnents.dart';
import 'package:site/ui/widgets/site_variable.dart';

import 'package:site/util/auth.dart';
import 'package:site/util/validator.dart';
import 'package:site/ui/widgets/loading.dart';

class SignInScreen extends StatefulWidget {
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;

  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: kMainbrowncolor,
      autofocus: false,
      autocorrect: true,
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
        hintStyle:TextStyle(
          fontSize: ScreenUtil()
          .setSp(
          kFontsize,
          allowFontScalingSelf:
          true),
      fontWeight:
      FontWeight.bold,
      fontFamily: 'RobotoSlab',
      color: kGrey,

    )

      ),
    );

    final password = TextFormField(
      cursorColor: kMainbrowncolor,
      autofocus: false,
      obscureText: true,
      controller: _password,
      validator: Validator.validatePassword,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.lock,
            color: kGrey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: kPasswordhint,
          hintStyle:TextStyle(
            fontSize: ScreenUtil()
                .setSp(
                kFontsize,
                allowFontScalingSelf:
                true),
            fontWeight:
            FontWeight.bold,
            fontFamily: 'RobotoSlab',
            color: kGrey,
          )
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onPressed: () {
          _emailLogin(
              email: _email.text, password: _password.text, context: context);
        },
        padding: EdgeInsets.all(12),
        color:kMainbrowncolor,
        child: Text(kSignin, style:TextStyle(
          fontSize: ScreenUtil()
              .setSp(
              kFontsize,
              allowFontScalingSelf:
              true),
          fontWeight:
          FontWeight.bold,
          fontFamily: 'RobotoSlab',
          color: kLightWhite,
        )),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        kQuestionthird,
          style:TextStyle(
            fontSize: ScreenUtil()
                .setSp(
                kFontsize,
                allowFontScalingSelf:
                true),
            fontWeight:
            FontWeight.bold,
            fontFamily: 'RobotoSlab',
            color: kGrey,
          )
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/forgot-password');
      },
    );

    final signUpLabel = FlatButton(
      child: Text(
        kQuestionsecond,
          style:TextStyle(
            fontSize: ScreenUtil()
                .setSp(
                kFontsize,
                allowFontScalingSelf:
                true),
            fontWeight:
            FontWeight.bold,
            fontFamily: 'RobotoSlab',
            color: kGrey,
          )
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/signup');
      },
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainbrowncolor,
        body: LoadingScreen(
            child: Column(
              children: <Widget>[

                Header(title:'SignIn',welcome: 'Welcome'),
                Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Expanded(
                    flex: 7,
                    child: Container(
                      decoration: new BoxDecoration(
                      color:kLightbrown,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),)
                      ),

                      padding: const EdgeInsets.symmetric( horizontal:24.0, vertical:50.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              email,
                              SizedBox(height: 24.0),
                              password,
                              SizedBox(height: 12.0),
                              loginButton,
                              forgotLabel,
                              signUpLabel
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            inAsyncCall: _loadingVisible),
      ),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _emailLogin(
      {String email, String password, BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        await _changeLoadingVisible();
        SystemChannels.textInput.invokeMethod('TextInput.hide');

        final user = await _auth.signInWithEmailAndPassword(email: email, password: password);

        if(user != null){
          //await Navigator.pushNamed(context, '/GetUsers');
          Variables.loggedInUseremail = email;
          Navigator.of(context).pushReplacement
            (MaterialPageRoute(builder: (context) => FriendsScreen()));
        }
      } catch (e) {


        _changeLoadingVisible();
        print("Sign In Error: $e");
        String exception = Auth.getExceptionText(e);
        Fluttertoast.showToast(
            msg: 'Sign In Error',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: kBlackcolor,
            textColor: kRedColor);


      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}


