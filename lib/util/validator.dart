import 'package:site/strings/strings.dart';

class Validator {
  static String validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return kEmailvalidator;
    else
      return null;
  }

  static String validatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return kPasswordvalidator;
    else
      return null;
  }

  static String validateName(String value) {
    if (value.isEmpty) {
      return kNamevalidator;
    }
    return null;
  }


  static String validateLocation(String value) {
    if (value.isEmpty) {
      return kLocationvalidator;
    }
    return null;
  }

  static String validateusername(String value) {
    if (value.isEmpty) {
      return kUsernameerror;
    }
    return null;
  }

  static String validatepnumber(String value) {
    if (value.isEmpty) {
      return kTypevalidator;
    }
    return null;
  }

  static String validateReport(String value) {
    if (value.isEmpty) {
      return kReportValidator;
    }
    return null;
  }

  static String validateSubject(String value) {
    if (value.isEmpty) {
      return kSubjectValidator;
    }
    return null;
  }

  static String validatepcity(String value) {
    if (value.isEmpty) {
      return kLocalgovtvalidator;
    }
    return null;
  }

  static String validateState(String value) {
    if (value.isEmpty) {
      return kStatevalidator;
    }

    return null;
  }

  static String validateDesc(String value) {
    if (value.isEmpty) {
      return kDescvalidator;
    }
    if (value.length < 2) {
      return kDescminvalidator;
    }
    if (value.length > 100) {
      return kDescmaxvalidator;
    }
    return null;
  }

  static String validateNumber(String value) {
    if (value.isEmpty) {
      return kPhonenumbervalidator;
    }
  }
}
