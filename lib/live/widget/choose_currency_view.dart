import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wm_cc/currency/presenter/currency_presenter.dart';
import 'package:wm_cc/general/utils/general_utils.dart';

import 'choose_currency_list.dart';

class ChooseCurrencyView extends StatelessWidget{
  final TextEditingController searchText = TextEditingController();
  final ChooseCurrencyListener cb;
  ChooseCurrencyView({
    required this.cb,});

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
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 15),
                              hintText: "Search for curreny",
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.black38,
                                size: 23,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 14)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ChooseCurrencyList(cb: (name, value){
                cb(name ,value);
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
typedef void ChooseCurrencyListener(String name, String value);