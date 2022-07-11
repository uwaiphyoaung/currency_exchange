import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wm_cc/database/dao/currency_dao.dart';
import 'package:wm_cc/general/entity/list/currency_list_entity.dart';
import 'package:wm_cc/general/env.dart';

import '../../general/api/api.dart';

part 'currency_list_event.dart';
part 'currency_list_state.dart';

class CurrencyListBloc extends Bloc<CurrencyListEvent, CurrencyState> {
  final api = Api.create(EnvValue.dev);

  CurrencyListBloc() : super(CurrencyState()) {

    on<CurrencyListEvent>((event, emit) { });

    on<LoadOfflineCurrencyList>((event, emit) async{
      var offlinedata = await CurrencyDao().getAllCurrencies();
      return emit(state.copyWith(
        status: offlinedata.isEmpty? CurrencyStatus.servererror: CurrencyStatus.success,
        currencies: offlinedata,
      ));
    });

    on<SearchCurrencyEvent>((event, emit) async{
      emit(state.copyWith(
        status: CurrencyStatus.reset,
        currencies: [],
      ));
      var offlinedata = await CurrencyDao().getSearchCurrency(event.value);
      return emit(state.copyWith(
        status: offlinedata.isEmpty? CurrencyStatus.servererror: CurrencyStatus.success,
        currencies: offlinedata,
      ));
    });

    on<FetchCurrencyList>((event, emit) async{
      try {
        var offlinedata = await CurrencyDao().getAllCurrencies();
        if(offlinedata.length<0){
          if (state.status == CurrencyStatus.initial) {
            final CurrencyListRes response = await api.getCurrencyList();
            if(response != null && response.success) {
              if (response.currencies.isNotEmpty) {
                CurrencyDao().deleteAll();
                CurrencyDao().addAll(response.currencies);
              }
              return emit(state.copyWith(
                status: CurrencyStatus.success,
                currencies: await CurrencyDao().getAllCurrencies(),
              ));
            }else{
              var offlinedata = await CurrencyDao().getAllCurrencies();
              return emit(state.copyWith(
                status: offlinedata.isEmpty? CurrencyStatus.servererror: CurrencyStatus.success,
                currencies: offlinedata,
              ));
            }
          }
        }
        return emit(state.copyWith(
          status: offlinedata.isEmpty? CurrencyStatus.servererror: CurrencyStatus.success,
          currencies: offlinedata,
        ));

      } on SocketException catch(_){
        var offlinedata = await CurrencyDao().getAllCurrencies();
        return emit(state.copyWith(
          status: offlinedata.isEmpty? CurrencyStatus.interneterror: CurrencyStatus.success,
          currencies: offlinedata,
        ));
      }catch(e){
        print(e.toString());
        var offlinedata = await CurrencyDao().getAllCurrencies();
        return emit(state.copyWith(
          status: offlinedata.isEmpty? CurrencyStatus.servererror: CurrencyStatus.success,
          currencies: offlinedata,
        ));
      }
    });
  }
}
