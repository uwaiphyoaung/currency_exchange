import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:wm_cc/currency/presenter/currency_presenter.dart';
import 'package:wm_cc/general/session/session_manager.dart';

import '../../live/presenter/live_rate_presenter.dart';
import '../../live/widget/choose_currency_view.dart';

class CurrentCurrencyView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CurrentCurrencyViewState();
}


class CurrentCurrencyViewState extends State<CurrentCurrencyView>{

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          CurrencyPresenter().loadOfflineCurrency(context);
          Get.to(()=> ChooseCurrencyView(cb: (name, value){
            SessionManager.getInstance().setLastChooseCurrencyRate(name);
            SessionManager.getInstance().setLastChooseCurrencyDesc(value);
            LiveRatePresenter().loadRate(
                context,
                source:name,
                sourceDesc:value,
                date:SessionManager.getInstance().getLastChooseDateRate());
            setState((){

            });
          }));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.w),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                border: Border.all(color: Theme.of(context).primaryColor)
            ),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Row(
              children: [
                Text(SessionManager.getInstance().getLastChooseCurrencyRate(), style: TextStyle(fontSize: 13.sp),),
                SizedBox(width: 7.w,),
                const Icon(Icons.expand_more_outlined)
              ],
            ),
          ),
        ),
      ),
    );
  }
}