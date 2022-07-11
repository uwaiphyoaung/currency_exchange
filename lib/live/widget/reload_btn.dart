import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../general/session/session_manager.dart';
import '../presenter/live_rate_presenter.dart';

class RatesReloadBtn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.faceSadTear, size: 13.w,),
              SizedBox(height: 3.h,),
              Text("Server Error", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
              SizedBox(height: 2.h),
              Text("This may be your apikey is expired or Server is under maintenance!" , textAlign: TextAlign.center, style: TextStyle(height: 1.7),),
              SizedBox(height: 3.h,),
              TextButton(
                onPressed: () {
                  LiveRatePresenter().loadRate(
                      context,
                      sourceDesc:SessionManager.getLastChooseCurrencyDesc(),
                      source:SessionManager.getLastChooseCurrencyRate(),
                      date:SessionManager.getLastChooseDateRate());
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                          (Set<MaterialState> states) {
                        return EdgeInsets.only(left: 5.w,right: 5.w,  top: 1.h, bottom: 1.h);
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.w),
                        )
                    )
                ),
                child:  Text("Reload", style: TextStyle(fontSize: 16.sp),),
              )
            ],
          ),
        )
    );
  }

}