import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wm_cc/database/dao/currency_dao.dart';
import 'package:wm_cc/database/dao/rates_dao.dart';
import 'package:wm_cc/general/utils/general_utils.dart';

import '../../general/api/api.dart';
import '../../general/entity/convert/convert_entity.dart';
import '../../general/entity/historical_convert/historical_convert_entity.dart';
import '../../general/env.dart';
import '../model/convert_item_model.dart';

part 'currency_converter_event.dart';
part 'currency_converter_state.dart';

class CurrencyConverterBloc extends Bloc<CurrencyConverterEvent, ConverterState> {
  final api = Api.create(EnvValue.dev);
  List<ConvertItemModel> dataList = [];

  CurrencyConverterBloc() : super(ConverterState()) {
    on<CurrencyConverterEvent>((event, emit) {});

    on<ConvertCurrencyByDate> ((event, emit) async {
      dataList = [];
      emit(state.copyWith(
          status: ConverterStatus.initial,
      ));
      try{
        if(event.date=="Today"){
          ConvertRes res = await api.covertCurrency(event.from, event.to, event.amount);
          if(res != null && res.success){
            dataList = [];
            CurrencyEntity ce1 = await CurrencyDao().getCurrencyByCode(res.query.from);
            CurrencyEntity ce2 = await CurrencyDao().getCurrencyByCode(res.query.to);
            dataList.add(ConvertItemModel(ce1.name, ce1.value, res.query.amount.toString(), ce2.name));
            dataList.add(ConvertItemModel(ce2.name, ce2.value, res.result.toString(), ce1.name));
            if(!event.isTop){
              dataList = dataList.reversed.toList();
            }
            return emit(state.copyWith(
              status: ConverterStatus.success,
                fail: false,
              data: dataList
            ));
          }else{
            //Fint USDMMK and calculate
            //not found show server error
            RatesEntity lum = await RatesDao().getRateByCode("${event.to}${event.from}");
            RatesEntity mul = await RatesDao().getRateByCode("${event.from}${event.to}");
            if(mul != null && mul.id! >0){
              dataList = [];
              double val;
              if(event.amount.contains(".")){
                val = (double.parse(mul.value) * double.parse(event.amount));
              }else{
                val = (double.parse(mul.value) * int.parse(event.amount));
              }
              CurrencyEntity ce1 = await CurrencyDao().getCurrencyByCode(event.from);
              CurrencyEntity ce2 = await CurrencyDao().getCurrencyByCode(event.to);
              dataList.add(ConvertItemModel(ce1.name, ce1.value, event.amount,ce2.name));
              dataList.add(ConvertItemModel(ce2.name, ce2.value, "${GeneralUtils.roundDouble(val,2)}",ce1.name));
              if(!event.isTop){
                dataList = dataList.reversed.toList();
              }
              return emit(state.copyWith(
                  status: ConverterStatus.success,
                  fail: false,
                  data: dataList
              ));
            }else if(lum != null && lum.id! >0){
              dataList = [];
              double val;
              if(event.amount.contains(".")){
                val = (double.parse(event.amount) / double.parse(lum.value) );
              }else{
                val = (int.parse(event.amount) / double.parse(lum.value) );
              }
              CurrencyEntity ce1 = await CurrencyDao().getCurrencyByCode(event.from);
              CurrencyEntity ce2 = await CurrencyDao().getCurrencyByCode(event.to);
              dataList.add(ConvertItemModel(ce1.name, ce1.value, event.amount,ce2.name));
              dataList.add(ConvertItemModel(ce2.name, ce2.value, "${GeneralUtils.roundDouble(val, 2)}",ce1.name));
              if(!event.isTop){
                dataList = dataList.reversed.toList();
              }
              return emit(state.copyWith(
                  status: ConverterStatus.success,
                  fail: false,
                  data: dataList
              ));
            }else{
              dataList = [];
              CurrencyEntity ce1 = await CurrencyDao().getCurrencyByCode(event.from);
              CurrencyEntity ce2 = await CurrencyDao().getCurrencyByCode(event.to);
              dataList.add(ConvertItemModel(ce1.name, ce1.value, event.amount, ce2.name));
              dataList.add(ConvertItemModel(ce2.name, ce2.value, "-", ce1.name));
              if(!event.isTop){
                dataList = dataList.reversed.toList();
              }
              return emit(state.copyWith(
                  status: ConverterStatus.success,
                  fail: true,
                  data: dataList
              ));
            }
          }
        }else{
          HistoricalConvertRes res = await api.covertByDate(event.from, event.to, event.amount, event.date);
          if(res != null && res.success){
            dataList = [];
            CurrencyEntity ce1 = await CurrencyDao().getCurrencyByCode(res.query.from);
            CurrencyEntity ce2 = await CurrencyDao().getCurrencyByCode(res.query.to);
            dataList.add(ConvertItemModel(ce1.name, ce1.value, res.query.amount.toString(), ce2.name));
            dataList.add(ConvertItemModel(ce2.name, ce2.value, res.result.toString(), ce1.name));
            if(!event.isTop){
              dataList = dataList.reversed.toList();
            }
            return emit(state.copyWith(
                status: ConverterStatus.success,
                fail: false,
                data: dataList
            ));
          }else{
            //Fint USDMMK and calculate
            //not found show server error
            RatesEntity lum = await RatesDao().getRateByCode("${event.to}${event.from}");
            RatesEntity mul = await RatesDao().getRateByCode("${event.from}${event.to}");
            if(mul != null && mul.id! >0){
              dataList = [];
              double val;
              if(event.amount.contains(".")){
                val = (double.parse(mul.value) * double.parse(event.amount));
              }else{
                val = (double.parse(mul.value) * int.parse(event.amount));
              }
              CurrencyEntity ce1 = await CurrencyDao().getCurrencyByCode(event.from);
              CurrencyEntity ce2 = await CurrencyDao().getCurrencyByCode(event.to);
              dataList.add(ConvertItemModel(ce1.name, ce1.value, event.amount,ce2.name));
              dataList.add(ConvertItemModel(ce2.name, ce2.value, "${GeneralUtils.roundDouble(val, 2)}",ce1.name));
              if(!event.isTop){
                dataList = dataList.reversed.toList();
              }
              return emit(state.copyWith(
                  status: ConverterStatus.success,
                  fail: false,
                  data: dataList
              ));
            }else if(lum != null && lum.id! >0){
              dataList = [];
              double val;
              if(event.amount.contains(".")){
                val = (double.parse(event.amount) / double.parse(lum.value) );
              }else{
                val = (int.parse(event.amount) / double.parse(lum.value) );
              }
              CurrencyEntity ce1 = await CurrencyDao().getCurrencyByCode(event.from);
              CurrencyEntity ce2 = await CurrencyDao().getCurrencyByCode(event.to);
              dataList.add(ConvertItemModel(ce1.name, ce1.value, event.amount,ce2.name));
              dataList.add(ConvertItemModel(ce2.name, ce2.value, "${GeneralUtils.roundDouble(val, 2)}",ce1.name));
              if(!event.isTop){
                dataList = dataList.reversed.toList();
              }
              return emit(state.copyWith(
                  status: ConverterStatus.success,
                  fail: false,
                  data: dataList
              ));
            }else{
              dataList = [];
              CurrencyEntity ce1 = await CurrencyDao().getCurrencyByCode(event.from);
              CurrencyEntity ce2 = await CurrencyDao().getCurrencyByCode(event.to);
              dataList.add(ConvertItemModel(ce1.name, ce1.value, event.amount, ce2.name));
              dataList.add(ConvertItemModel(ce2.name, ce2.value, "-", ce1.name));
              if(!event.isTop){
                dataList = dataList.reversed.toList();
              }
              return emit(state.copyWith(
                  status: ConverterStatus.success,
                  fail: true,
                  data: dataList
              ));
            }
          }
        }

      }catch(e){
        print(e);
        //Fint USDMMK and calculate
        //not found show server error
        RatesEntity mul = await RatesDao().getRateByCode("${event.from}${event.to}");
        RatesEntity lum = await RatesDao().getRateByCode("${event.to}${event.from}");
        if(mul != null && mul.id! >0){
          dataList = [];
          double val;
          if(event.amount.contains(".")){
            val = (double.parse(mul.value) * double.parse(event.amount));
          }else{
            val = (double.parse(mul.value) * int.parse(event.amount));
          }
          CurrencyEntity ce1 = await CurrencyDao().getCurrencyByCode(event.from);
          CurrencyEntity ce2 = await CurrencyDao().getCurrencyByCode(event.to);
          dataList.add(ConvertItemModel(ce1.name, ce1.value, event.amount,ce2.name));
          dataList.add(ConvertItemModel(ce2.name, ce2.value, "${GeneralUtils.roundDouble(val, 2)}",ce1.name));
          if(!event.isTop){
            dataList = dataList.reversed.toList();
          }
          return emit(state.copyWith(
              status: ConverterStatus.success,
              fail: false,
              data: dataList
          ));
        }else if(lum != null && lum.id! >0){
          dataList = [];
          double val;
          if(event.amount.contains(".")){
            val = (double.parse(event.amount) / double.parse(lum.value) );
          }else{
            val = (int.parse(event.amount) / double.parse(lum.value) );
          }
          CurrencyEntity ce1 = await CurrencyDao().getCurrencyByCode(event.from);
          CurrencyEntity ce2 = await CurrencyDao().getCurrencyByCode(event.to);
          dataList.add(ConvertItemModel(ce1.name, ce1.value, event.amount,ce2.name));
          dataList.add(ConvertItemModel(ce2.name, ce2.value, "${GeneralUtils.roundDouble(val, 2)}",ce1.name));
          if(!event.isTop){
            dataList = dataList.reversed.toList();
          }
          return emit(state.copyWith(
              status: ConverterStatus.success,
              fail: false,
              data: dataList
          ));
        }else{
          dataList = [];
          CurrencyEntity ce1 = await CurrencyDao().getCurrencyByCode(event.from);
          CurrencyEntity ce2 = await CurrencyDao().getCurrencyByCode(event.to);
          dataList.add(ConvertItemModel(ce1.name, ce1.value, event.amount, ce2.name));
          dataList.add(ConvertItemModel(ce2.name, ce2.value, "-", ce1.name));
          if(!event.isTop){
            dataList = dataList.reversed.toList();
          }
          return emit(state.copyWith(
              status: ConverterStatus.success,
              fail: true,
              data: dataList
          ));
        }
      }
    });

    on<ReverseOrderEvent> ((event, emit) {
      if(state.status == ConverterStatus.success && dataList.isNotEmpty){
        dataList = dataList.reversed.toList();
        return emit(state.copyWith(
            status: ConverterStatus.success,
            data: dataList
        ));
      }
    });
  }
}
