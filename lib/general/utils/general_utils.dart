import 'dart:math';

import 'package:flutter/material.dart';

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
}