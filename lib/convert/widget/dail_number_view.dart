import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DailButton extends StatelessWidget{
  final String value;
  ButtonClickListener cb;
  DailButton(this.value, {required this.cb});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.h),
      child: MaterialButton(
        onPressed: () {
          cb(value);
        },
        color: Colors.lightBlue,
        textColor: Colors.white,
        child: Text(value, style: TextStyle(fontSize: 25.sp),),
        padding: EdgeInsets.all(3.w),
        shape: CircleBorder(),
      ),
    );
  }

}

typedef void ButtonClickListener(String val);