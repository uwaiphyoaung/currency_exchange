import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wm_cc/general/session/session_manager.dart';

import '../../currency/presenter/currency_presenter.dart';
import '../../general/utils/general_utils.dart';
import '../presenter/convert_presenter.dart';
import 'currency_list.dart';

class SelectableCurrencyList extends StatelessWidget{
  final TextEditingController searchText = TextEditingController();

  final bool isTop;
  final String currentCurrency;
  final String otherCurrency;
  final String currentAmount;

  SelectableCurrencyList({
    required this.isTop,
    required this.currentCurrency,
    required this.otherCurrency,
    required this.currentAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 5.h, left: 5.w, right: 5.w, top: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.chevron_left)
                    ),
                    Expanded(
                      child: Container(
                        child: TextField(
                          onSubmitted: (value) {
                            handleSearchClick(value, context);
                          },
                          textInputAction: TextInputAction.search,
                          autofocus: false,
                          controller: searchText,
                          onChanged: (text) {
                            if(text.isNotEmpty){
                              CurrencyPresenter().searchCurrency(context, text);
                            }
                          },
                          cursorColor: Colors.grey,
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(fontSize: 15),
                              hintText: "Search for curreny",
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.black38,
                                size: 23,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 14)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              CurrencyList(cb: (value){
                print("Selectable data : " + value);
                //Todo: call api
                if(value == otherCurrency){
                  // other -> current
                  ConverterPresenter().convertCurrencyByDate(context, true,
                      from: otherCurrency,
                      to: currentCurrency,
                      amount: currentAmount,
                      date: SessionManager.getInstance().getLastConvertDate());
                }else{
                  // value -> other
                  ConverterPresenter().convertCurrencyByDate(context, true,
                      from: value,
                      to: otherCurrency,
                      amount: currentAmount,
                      date: SessionManager.getInstance().getLastConvertDate());
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  void handleSearchClick(String value, BuildContext context) {
    if (searchText.text.isNotEmpty) {
      GeneralUtils.hideKeyboard(context);
      CurrencyPresenter().searchCurrency(context, value);
    }
  }
}