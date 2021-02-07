import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Flash extends StatefulWidget{
  @override
  _FlashState createState() => _FlashState();
}
class _FlashState extends State<Flash>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: CircularProgressIndicator(

        )
    );
  }
}