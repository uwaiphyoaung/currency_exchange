import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:wm_cc/convert/convert_screen.dart';
import 'package:wm_cc/general/utils/datetime_utils.dart';
import 'package:wm_cc/general/utils/general_utils.dart';
import 'package:wm_cc/live/bloc/live_rate_bloc.dart';
import 'package:wm_cc/live/widget/reload_btn.dart';
import 'package:wm_cc/live/widget/shimmer_loading.dart';

import '../../convert/model/convert_item_model.dart';

class RateResultList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.only(bottom: 8.h),
      child: BlocBuilder<LiveRateBloc, LiveRateState>(
        builder: (context, state) {
          switch (state.status) {
            case LiveRateStatus.servererror:
              return  RatesReloadBtn();
            case LiveRateStatus.interneterror:
              return const Center(child: Text("Internet Connection Lost!"));
            case LiveRateStatus.success:
              if (state.rates.isEmpty) {
                return const Center(child: Text('No Currencies'));
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.rates.length,
                itemBuilder: (context, index){
                  return Card(
                    elevation: 0.0,
                    child: InkWell(
                      onTap: (){
                        Get.to(()=>ConvertScreen(
                          data: ConvertItemModel(state.rates[index].name.substring(0, 3),"","1",state.rates[index].name.substring(3)),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 2.h,bottom: 2.h, left: 5.w, right: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(DateTimeUtils.getDateFromTimestamp(state.rates[index].timestamp), style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w100),),
                                  SizedBox(height: 1.h,),
                                  Text(GeneralUtils.getCurrency(state.rates[index].name), style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),)
                                ],
                              ),
                            ),
                            Text(state.rates[index].value, style: TextStyle(fontSize: 14.sp),)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            default:
              return const ShimmerLoadingWidget();
          }
        },
      ),
    );
  }

}