import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GeneralUtils{
  static String getCurrency(String data){
    return "${data.substring(0, 3)}/${data.substring(3)}";
  }
  static void hideKeyboard(BuildContext context){
    FocusScope.of(context).unfocus();
  }
  static double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  static void showMsg(BuildContext context, String data, bool state){
    var snackBar = SnackBar(
      margin: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
      padding:
      const EdgeInsets.only(left: 15.0, right: 15.0, top: 10, bottom: 10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: state ? Colors.green : Colors.redAccent,
      content: Text(data),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}