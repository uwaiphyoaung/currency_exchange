import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wm_cc/currency/bloc/currency_list_bloc.dart';

class CurrencyPresenter{
  void loadOfflineCurrency(BuildContext context) =>
      BlocProvider.of<CurrencyListBloc>(context).add(LoadOfflineCurrencyList());

  void searchCurrency(BuildContext context, String value) =>
      BlocProvider.of<CurrencyListBloc>(context).add(SearchCurrencyEvent(value));

}