

import 'package:flutter/material.dart';
import 'package:site/colors/colors.dart';

import 'package:site/ui/screens/splashscreen.dart';


import 'package:site/util/state_widget.dart';

import 'package:site/ui/screens/home.dart';
import 'package:site/ui/screens/sign_in.dart';
import 'package:site/ui/screens/sign_up.dart';
import 'package:site/ui/screens/forgot_password.dart';

class MyApp extends StatelessWidget {
  MyApp() {
    //Navigation.initPaths();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp Title',

      //theme: buildTheme(),
      theme:ThemeData(
        primarySwatch: primaryOrange,
        fontFamily: 'Rajdhani',
      ),
      //onGenerateRoute: Navigation.router.generator,
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/home': (context) => HomeScreen(),


      },
    );


  }
}


void main() {
  StateWidget stateWidget = new StateWidget(
    child: new MyApp(),
  );
  runApp(stateWidget);

}


