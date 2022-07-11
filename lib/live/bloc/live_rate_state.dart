part of 'live_rate_bloc.dart';

enum LiveRateStatus { initial, success, servererror, interneterror, reset }

class LiveRateState{

  final LiveRateStatus status;
  final List<RatesEntity> rates;
  LiveRateState({
    this.status = LiveRateStatus.initial,
    this.rates = const <RatesEntity>[],
  });

  LiveRateState copyWith({
    LiveRateStatus? status,
    List<RatesEntity>? rates,
  }) {
    return LiveRateState(
        status: status ?? this.status,
        rates: rates ?? this.rates
    );
  }
}
