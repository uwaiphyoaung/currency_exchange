import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:wm_cc/currency/bloc/currency_list_bloc.dart';

class ChooseCurrencyList extends StatelessWidget{
  final CurrencySelectListener cb;

  ChooseCurrencyList({required this.cb});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 13.h),
      child: BlocBuilder<CurrencyListBloc, CurrencyState>(
        builder: (context, state) {
          switch (state.status) {
            case CurrencyStatus.servererror:
              return const Center(child: Text("Server Error"));
            case CurrencyStatus.interneterror:
              return const Center(child: Text("Internet Connection Lost!"));
            case CurrencyStatus.success:
              if (state.currencies.isEmpty) {
                return const Center(child: Text('No Currencies'));
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.currencies.length,
                itemBuilder: (context, index){
                  return Card(
                    elevation: 0.0,
                    child: InkWell(
                      onTap: (){
                        cb(state.currencies[index].name, state.currencies[index].value);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 2.h,bottom: 2.h, left: 10.w, right: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.currencies[index].name, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w300),),
                                    SizedBox(height: 1.h,),
                                    Text(state.currencies[index].value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

}

typedef void CurrencySelectListener(String name, String value);