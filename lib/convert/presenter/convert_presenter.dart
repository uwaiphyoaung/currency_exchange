import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wm_cc/convert/bloc/currency_converter_bloc.dart';

class ConverterPresenter{
  void convertCurrencyByDate(BuildContext context, bool isTop, {
        required String from,
        required String to,
        required String amount,
        required String date}) =>
      BlocProvider.of<CurrencyConverterBloc>(context).add(
          ConvertCurrencyByDate(
            isTop,
            from: from,
            to: to,
            date: date,
            amount: amount
          ));

  void reverseOrder(BuildContext context) =>
      BlocProvider.of<CurrencyConverterBloc>(context).add(
          ReverseOrderEvent());
}