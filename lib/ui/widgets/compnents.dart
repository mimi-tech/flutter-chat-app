import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:site/colors/colors.dart';
import 'package:site/dimens/dimens.dart';

class Header extends StatelessWidget {
  Header({this.title,this.welcome});
  final String title;
  final String welcome;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        width:double.infinity,
        height: ScreenUtil().setWidth(300),
        color: kMainbrowncolor,
child:Container(
  margin: EdgeInsets.symmetric(horizontal:24.0, vertical:24.0),
  child:   Column(
    children: <Widget>[

      Align(
        alignment:Alignment.topLeft,
        child: CircleAvatar(
            backgroundColor: Colors.transparent,

            child: ClipOval(
              child: Image.asset(
                'assets/images/default.png',
                fit: BoxFit.cover,
                width: 50.0,
                height: 50.0,
              ),
            )),

      ),
SizedBox(height:15.0),
      Align(
        alignment: Alignment.topLeft,
        child:Text(welcome,
        style:TextStyle(
          fontSize: ScreenUtil()
              .setSp(
              kFontsize,
              allowFontScalingSelf:
              true),
          fontWeight:
          FontWeight.bold,
          fontFamily: 'RobotoSlab',
          color: Colors.grey,
        )),
      ),
      SizedBox(height:15.0),
      Align(
        alignment: Alignment.topLeft,
        child:Text(title,
            style:TextStyle(
              fontSize: ScreenUtil()
                  .setSp(
                  kFontsizesignin,
                  allowFontScalingSelf:
                  true),
              fontWeight:
              FontWeight.bold,
              fontFamily: 'RobotoSlab',
              color: kLightWhite,
            )),
      )
    ],
  ),
)
      ),
    );
  }
}