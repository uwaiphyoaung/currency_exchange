import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../general/session/session_manager.dart';
import '../presenter/live_rate_presenter.dart';

class RatesReloadBtn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
          onPressed: () {
            LiveRatePresenter().loadRate(
                context,
                sourceDesc:SessionManager.getInstance().getLastChooseCurrencyDesc(),
                source:SessionManager.getInstance().getLastChooseCurrencyRate(),
                date:SessionManager.getInstance().getLastChooseDateRate());
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
        ));
  }

}