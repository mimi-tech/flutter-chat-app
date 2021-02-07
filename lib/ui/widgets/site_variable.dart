import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:site/colors/colors.dart';
import 'package:site/dimens/dimens.dart';

class Variables {
  static File imageURI;

  static String lastName;
  static String firstName;
  static String phone;
  static String email;
  static String profilePicture;
  static String ph;
  static String lpr;
  static String lfn;
  static String em;
  static String cname;
  static String cid;
  static String rid;
  static String firstpf;
  static String firstname;
  static String userAmounts = 100 as String;
static int userAmount = 100;
  static String profilePictureCopy;
  static String state ;
 static String property_type = '' ;
 static String pLocation;
  static String localGovt = '' ;
static String Lu;
static String loggedInUseremail;
static String loggedInUseruid;
  static int useridnumber;
  static String getfirstName;
  static String getpf;
  static String subject ;
  static String message = '';
  static String userselectedcountry;
  static String userselectedstate;
  static String userselectedlocalGovt;
  static String ptype;
 static  String description;
 static FirebaseUser loggedInUser;
 static String playvideo;
 static String desc;
  static String emails;
static String StateName;
static String LgName;
static String pstate = '' ;
  static String property_country = '' ;
  static String pNumber;
  static String pcity;
  static String pcountry;
  static String username;
static String choseproperty;
static String pv;
static String downloadvideo;
static String  emailId = 'miriamnigeria44@gmail.com';
static int savedvideoid;
static bool showLga = false;
static String filterUsername;
static bool fontSizeScaling = false;
  static File uploadVideourl;
  static StorageUploadTask uploadTask;
  static File fileName;
  static String uploadedVideoUrl ;
  static String uploadedVideoName = '';
  static File uploadVideofile;
  static String playVideo;


///saved videos
static String fname;
static String lname;
static String descriptions;
static String profilepix;
static String uservideos;
static int un;
static String fan;
static String dates;
static String phoneno;





  static String sdt;
  static String sde;
  static String sfn;
  static String sim;
  static String sln;
  static String spp;
  static String sph;
  static String spr;
  static String sun;
  static String sfa;

///users update

  static String firstNameupdates;
  static String lastNameupdates;
  static String emailupdates;
  static String phoneupdates;
  static String usernameupdates;
  static String profilePictureupdates;
  static String firstNameupdate;
  static String lastNameupdate;
  static String emailupdate;
  static String phoneupdate;
  static String usernameupdate;
  static String profilePictureupdate;
  static final textstyles =
  TextStyle(
    fontSize: ScreenUtil()
        .setSp(
        kFontsize,
        allowFontScalingSelf:
        true),
    fontWeight:
    FontWeight.bold,
    fontFamily: 'RobotoSlab',
    color: kGrey,
  );

  static final textstylesbtn =
  TextStyle(fontSize: ScreenUtil()
      .setSp(
      kFontsize,
      allowFontScalingSelf:
      true),
    fontWeight:
    FontWeight.bold,
    fontFamily: 'RobotoSlab',
    color: kLightWhite,
  );
  static final textstylesmain =
  TextStyle(fontSize: ScreenUtil()
      .setSp(
      kFontsize,
      allowFontScalingSelf:
      true),
    fontWeight:
    FontWeight.bold,
    fontFamily: 'RobotoSlab',
    color: kBlackcolor,
  );


}





