import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:wm_cc/convert/model/convert_item_model.dart';

import '../../currency/presenter/currency_presenter.dart';
import 'selectable_currency_list.dart';
import 'calculator_widget.dart';

class ConvertItemView extends StatelessWidget{
  final ConvertItemModel data;
  final int index;

  ConvertItemView(this.data,this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.w)
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: 1.h, left: 2.w, right: 2.w, top: 1.h),
        child: Column(
          children: [
            ListTile(
              onTap: (){
                CurrencyPresenter().loadOfflineCurrency(context);
                Get.to(()=> SelectableCurrencyList(
                  isTop: index==0,
                  currentAmount: data.amount=="-"?"1":data.amount,
                  currentCurrency: data.code,
                  otherCurrency: data.otherCode,
                ));
              },
              title: Text(data.code, style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text(data.desc),
              trailing: Icon(Icons.chevron_right),
            ),
            SizedBox(height: 3.h,),
            Card(
              elevation: 0.0,
              child: InkWell(
                onTap: (){
                  Get.to(()=> CalculatorWidget(
                    clickFrom: data.code,
                    otherCurrency: data.otherCode,
                    isTop: index==0,
                  ));
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 2.h, left: 2.w, top: 2.h),
                  child: Row(
                    children: [
                      Text(data.amount, style: TextStyle(fontSize: 18.sp),)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}