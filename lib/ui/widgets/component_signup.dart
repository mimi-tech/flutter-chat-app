import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:site/colors/colors.dart';
import 'package:site/dimens/dimens.dart';
import 'package:site/ui/widgets/site_variable.dart';

class HeaderRegister extends StatelessWidget {
  HeaderRegister({this.title,this.welcome});
  final String title;
  final String welcome;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
          width:double.infinity,
          height: ScreenUtil().setWidth(300),
          color: kMainbrowncolor,
          child:Container(
            margin: EdgeInsets.symmetric(horizontal:24.0, vertical:24.0),
            child:   Column(
              children: <Widget>[

                Align(
                  alignment: Alignment.topLeft,
                  child:Text(welcome,
                      style:Variables.textstyles),
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