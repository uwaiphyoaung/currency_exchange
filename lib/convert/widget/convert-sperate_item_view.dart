import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ConvertSperateView extends StatelessWidget{
  VoidCallback onSwitchClick;
  ConvertSperateView({required this.onSwitchClick});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.w),
                color: Colors.white
            ),
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Text("=", style: TextStyle(fontSize: 25.sp),),
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith(
                    (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70),
                ),
              ),
              backgroundColor:
              MaterialStateProperty.resolveWith(
                    (states) => Colors.orange,
              ),
            ),
            onPressed: () {
              onSwitchClick();
            },
            child: Row(
              children: [
                Icon(Icons.compare_arrows),
                SizedBox(width: 5.w,),
                Text("Switch currencies", style: TextStyle(fontSize: 13.sp),)
              ],
            ),
          )
        ],
      ),
    );
  }

}