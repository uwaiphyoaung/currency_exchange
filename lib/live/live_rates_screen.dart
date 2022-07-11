import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:wm_cc/general/session/session_manager.dart';
import 'package:wm_cc/general/utils/datetime_utils.dart';
import 'package:wm_cc/live/presenter/live_rate_presenter.dart';
import 'package:wm_cc/live/widget/current_date_view.dart';
import 'package:wm_cc/live/widget/rates_result_list.dart';

import 'widget/current_currency_view.dart';

class LiveRatesScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LiveRatesScreenState();
}

class LiveRatesScreenState extends State<LiveRatesScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: NewGradientAppBar(
        elevation: 1.0,
        title: Text("Currency Rates"),
        centerTitle: true,
        gradient: LinearGradient(colors: [Colors.orangeAccent, Colors.lightBlueAccent, Colors.blueGrey]),
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 5.h, left: 5.w, right: 5.w, top: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CurrentCurrencyView(),
                    CurrentDateView(cb: (value){
                      print("Date Data : ${value}");
                      SessionManager.getInstance().setLastChooseDateRate(value);
                      LiveRatePresenter().loadRate(
                          context,
                          sourceDesc:SessionManager.getInstance().getLastChooseCurrencyDesc(),
                          source:SessionManager.getInstance().getLastChooseCurrencyRate(),
                          date:value);
                    }),
                  ],
                ),
              ),
              RateResultList()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    LiveRatePresenter().loadRate(
        context,
        source: SessionManager.getInstance().getLastChooseCurrencyRate(),
        sourceDesc: SessionManager.getInstance().getLastChooseCurrencyDesc(),
        date: "Today");
  }
}