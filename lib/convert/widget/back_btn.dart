import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BackBtn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      height: 11.h,
      width: 30.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
            width: 10.h,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                ),
                backgroundColor:
                MaterialStateProperty.resolveWith(
                      (states) => Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_drop_down, color: Colors.blue,size: 10.w,),
            ),
          )
        ],
      ),
    );
  }

}