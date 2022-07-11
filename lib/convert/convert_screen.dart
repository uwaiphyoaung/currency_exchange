import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:wm_cc/convert/bloc/currency_converter_bloc.dart';
import 'package:wm_cc/convert/presenter/convert_presenter.dart';
import 'package:wm_cc/convert/widget/convert-sperate_item_view.dart';
import 'package:wm_cc/convert/widget/convert_item_view.dart';
import 'package:wm_cc/convert/widget/convert_shimmer_loading.dart';
import 'package:wm_cc/general/session/session_manager.dart';

import '../live/widget/current_date_view.dart';
import 'model/convert_item_model.dart';

class ConvertScreen extends StatefulWidget{
  ConvertItemModel? data;
  ConvertScreen({this.data});

  @override
  State<StatefulWidget> createState() => ConvertScreenState(data: data);
}

class ConvertScreenState extends State<ConvertScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: NewGradientAppBar(
        elevation: 1.0,
        title: Text("Currency Converter"),
        centerTitle: true,
        gradient: LinearGradient(colors: [Colors.brown, Colors.lightBlueAccent, Colors.blueGrey]),
      ),
      body: SafeArea(
        child: BlocBuilder<CurrencyConverterBloc, ConverterState>(
          builder: (context, state) {
            switch (state.status) {
              case ConverterStatus.servererror:
                return const Center(child: Text("Server Error"));
              case ConverterStatus.interneterror:
                return const Center(child: Text("Internet Connection Lost!"));
              case ConverterStatus.success:
                if (state.data.isEmpty) {
                  return const Center(child: Text('Can Calculate Right Now!'));
                }
                return Container(
                  padding: EdgeInsets.only(bottom: 5.h, left: 5.w, right: 5.w, top: 2.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 2.h, left: 2.w, right: 2.w, top: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              CurrentDateView(cb: (value){
                                print("Date Data : ${value}");
                                SessionManager.setLastConvertDate(value);
                                ConverterPresenter().convertCurrencyByDate(
                                    context,
                                    true,
                                    from: state.data[0].code,
                                    to: state.data[1].code,
                                    amount: state.data[0].amount,
                                    date: value);
                              }),
                            ],
                          ),
                        ),
                        Container(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.data.length,
                            itemBuilder: (context, index) {
                              return ConvertItemView(state.data[index], index);
                            },
                            separatorBuilder: (context, index) {
                              return ConvertSperateView(
                                onSwitchClick: (){
                                  ConverterPresenter().reverseOrder(context);
                                },);
                            },
                          ),
                        ),
                        state.fail?
                        Container(
                          padding: EdgeInsets.only(top: 2.h,bottom: 1.h),
                          child: TextButton(
                            onPressed: () {
                              ConverterPresenter().convertCurrencyByDate(
                                  context,
                                  state.data[1].amount=="-",
                                  from: state.data[0].code,
                                  to: state.data[1].code,
                                  amount: state.data[0].amount,
                                  date: SessionManager.getLastConvertDate());
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
                            child:  Text("Retry", style: TextStyle(fontSize: 16.sp),),),
                        ):
                            Container()
                      ],
                    ),
                  ),
                );
              default:
                return const ConvertLoadingWidget();
            }
          },
        ),
      ),
    );
  }

  ConvertItemModel? data;
  ConvertScreenState({this.data});

  @override
  void initState() {
    super.initState();
    SessionManager.setLastConvertDate("Today");
    if(data == null){
      ConverterPresenter().convertCurrencyByDate(context, true,
          from: "USD",
          to: "MMK",
          amount: "1",
          date: SessionManager.getLastConvertDate());
    }else{
      ConverterPresenter().convertCurrencyByDate(context, true,
          from: data!.code,
          to: data!.otherCode,
          amount: "1",
          date: SessionManager.getLastConvertDate());
    }
  }
}