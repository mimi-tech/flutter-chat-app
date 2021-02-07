import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:site/colors/colors.dart';
import 'package:site/dimens/dimens.dart';
import 'package:site/strings/strings.dart';
import 'package:site/ui/widgets/compnents.dart';

import 'package:site/util/auth.dart';
import 'package:site/util/validator.dart';
import 'package:site/ui/widgets/loading.dart';

class ForgotPasswordScreen extends StatefulWidget {
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;
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
      autofocus: false,
      controller: _email,
      validator: Validator.validateEmail,
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

      ),
    );

    final forgotPasswordButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onPressed: () {
          _forgotPassword(email: _email.text, context: context);
        },
        padding: EdgeInsets.all(12),
        color: kMainbrowncolor,
        child: Text(kForgotpassword, style:TextStyle(
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

    final signInLabel = FlatButton(
      child: Text(
        kSignin,
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
        Navigator.pushNamed(context, '/signin');
      },
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainbrowncolor,
        body: LoadingScreen(
            child: Column(
              children: <Widget>[
                Header(title:'Reset Password',welcome: 'Welcome'),
                Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Expanded(
                    flex:7,
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

                                email,
                                SizedBox(height: 12.0),
                                forgotPasswordButton,
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
            inAsyncCall: _loadingVisible),
      ),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _forgotPassword({String email, BuildContext context}) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_formKey.currentState.validate()) {
      try {
        await _changeLoadingVisible();
        await Auth.forgotPasswordEmail(email);
        await _changeLoadingVisible();
        Fluttertoast.showToast(
            msg: kForgotpasswordstatementsecond,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: kBlackcolor,
            textColor: kRedColor);

      } catch (e) {
        _changeLoadingVisible();
        print("Forgot Password Error: $e");
        String exception = Auth.getExceptionText(e);

        Fluttertoast.showToast(
            msg: 'Forgot Password Error',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: kBlackcolor,
            textColor: kRedColor);

      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}
