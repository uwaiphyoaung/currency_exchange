import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wm_cc/database/dao/currency_dao.dart';
import 'package:wm_cc/database/dao/rates_dao.dart';
import 'package:wm_cc/database/dao/saved_currency_dao.dart';
import 'package:wm_cc/general/entity/live/live_entity.dart';
import 'package:wm_cc/general/utils/datetime_utils.dart';

import '../../general/api/api.dart';
import '../../general/entity/historical/historical_entity.dart';
import '../../general/env.dart';
import '../../general/session/session_manager.dart';

part 'live_rate_event.dart';
part 'live_rate_state.dart';

class LiveRateBloc extends Bloc<LiveRateEvent, LiveRateState> {
  final api = Api.create(EnvValue.dev);

  LiveRateBloc() : super(LiveRateState()) {

    on<LiveRateEvent>((event, emit) { });

    on<FetchRatesCurrencyAndDate>((event, emit) async{
      try {
        emit(state.copyWith(
          status: LiveRateStatus.initial,
          ),
        );
        if(DateTimeUtils.canCheckRates(int.parse(SessionManager.getLastFetchDate()))){
          if(event.date=="Today"){
            final LiveCurrencyRes response = await api.getLiveCurrencyBySource(event.source);
            if(response != null && response.success) {
              if (response.quotes.isNotEmpty) {
                // Saving for offline
                SavedCurrencyDao().add(CurrencyEntity(name: event.source, value: event.sourceDesc));
                RatesDao().deleteAll();
                RatesDao().addAll(
                    response.quotes,
                    date: DateTimeUtils.getCurrentDate(),
                    timestamp: response.timestamp,
                    source: event.source
                );

                SessionManager.setLastChooseCurrencyRate(event.source);
                SessionManager.setLastChooseCurrencyDesc(event.sourceDesc);
                SessionManager.setLastFetchDate("${DateTime.now().millisecondsSinceEpoch}");
              }
              return emit(state.copyWith(
                status: LiveRateStatus.success,
                rates: await RatesDao().getFilter(
                    date: DateTimeUtils.getCurrentDate(),
                    source: event.source
                ),
              ));
            }else{
              var offlinedata = await RatesDao().getFilter(
                  date: DateTimeUtils.getCurrentDate(),
                  source: event.source
              );
              return emit(state.copyWith(
                status: offlinedata.isEmpty? LiveRateStatus.servererror: LiveRateStatus.success,
                rates: offlinedata,
              ));
            }
          }else{
            final HistoricalCurrencyRes response = await api.getHistoricalRatesBySource(event.date,event.source);
            if(response != null && response.success) {
              if (response.quotes.isNotEmpty) {
                // Saving for offline
                SavedCurrencyDao().add(CurrencyEntity(name: event.source, value: event.sourceDesc));
                RatesDao().deleteAll();
                RatesDao().addAll(
                    response.quotes,
                    date: event.date,
                    timestamp: response.timestamp,
                    source: event.source
                );
                SessionManager.setLastChooseCurrencyRate(event.source);
                SessionManager.setLastChooseCurrencyDesc(event.sourceDesc);
                SessionManager.setLastFetchDate("${DateTime.now().millisecondsSinceEpoch}");
              }
              return emit(state.copyWith(
                status: LiveRateStatus.success,
                rates: await RatesDao().getFilter(
                    date: event.date,
                    source: event.source
                ),
              ));
            }else{
              var offlinedata = await RatesDao().getFilter(
                  date: event.date,
                  source: event.source
              );
              return emit(state.copyWith(
                status: offlinedata.isEmpty? LiveRateStatus.servererror: LiveRateStatus.success,
                rates: offlinedata,
              ));
            }
          }
        }else{
          var offlinedata = await RatesDao().getAllItems();
          return emit(state.copyWith(
            status: offlinedata.isEmpty? LiveRateStatus.servererror: LiveRateStatus.success,
            rates: offlinedata,
          ));
        }

      } on SocketException catch(_){
        var offlinedata = await RatesDao().getFilter(
            date: event.date=="Today"?DateTimeUtils.getCurrentDate():event.date,
            source: event.source
        );
        return emit(state.copyWith(
          status: offlinedata.isEmpty? LiveRateStatus.interneterror: LiveRateStatus.success,
          rates: offlinedata,
        ));
      }catch(e){
        print(e.toString());
        emit(state.copyWith(
          status: LiveRateStatus.initial,
        ));
        var offlinedata = await RatesDao().getFilter(
            date: event.date=="Today"?DateTimeUtils.getCurrentDate():event.date,
            source: event.source
        );
        return emit(state.copyWith(
          status: offlinedata.isEmpty? LiveRateStatus.servererror: LiveRateStatus.success,
          rates: offlinedata,
        ));
      }
    });
  }
}
