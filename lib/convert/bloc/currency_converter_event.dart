part of 'currency_converter_bloc.dart';

@immutable
abstract class CurrencyConverterEvent {}

class ConvertCurrencyByDate extends CurrencyConverterEvent{
  final bool isTop;
  final String from;
  final String to;
  final String amount;
  final String date;
ConvertCurrencyByDate(this.isTop,{required this.from, required this.to, required this.amount, required this.date});
}

class ReverseOrderEvent extends CurrencyConverterEvent{}
