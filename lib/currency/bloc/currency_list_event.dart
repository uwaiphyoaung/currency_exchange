part of 'currency_list_bloc.dart';

@immutable
abstract class CurrencyListEvent {}

class FetchCurrencyList extends CurrencyListEvent{}

class LoadOfflineCurrencyList extends CurrencyListEvent{}

class SearchCurrencyEvent extends CurrencyListEvent{
  final String value;

  SearchCurrencyEvent(this.value);
}
