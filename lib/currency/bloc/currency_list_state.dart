part of 'currency_list_bloc.dart';

enum CurrencyStatus { initial, success, servererror, interneterror, reset }

class CurrencyState{

  final CurrencyStatus status;
  final List<CurrencyEntity> currencies;
  CurrencyState({
    this.status = CurrencyStatus.initial,
    this.currencies = const <CurrencyEntity>[],
  });

  CurrencyState copyWith({
    CurrencyStatus? status,
    List<CurrencyEntity>? currencies,
  }) {
    return CurrencyState(
      status: status ?? this.status,
      currencies: currencies ?? this.currencies
    );
  }
}