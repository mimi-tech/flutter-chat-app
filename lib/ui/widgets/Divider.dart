import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:site/colors/colors.dart';

class Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0,),
      height: 1.5,
      color: kGrey,
    );
  }
}