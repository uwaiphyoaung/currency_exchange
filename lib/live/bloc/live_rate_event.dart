part of 'live_rate_bloc.dart';

@immutable
abstract class LiveRateEvent {}

class FetchRatesCurrencyAndDate extends LiveRateEvent{
  final String source;
  final String sourceDesc;
  final String date;
  FetchRatesCurrencyAndDate({required this.source, required this.date, required this.sourceDesc});
}
