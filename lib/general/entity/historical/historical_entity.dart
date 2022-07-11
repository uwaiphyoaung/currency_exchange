import 'package:json_annotation/json_annotation.dart';
part 'historical_entity.g.dart';

@JsonSerializable()
class HistoricalCurrencyRes{
  late bool success;
  late bool historical;
  late String date;
  late int timestamp;
  late String source;
  late Map<String, num> quotes;


  HistoricalCurrencyRes(this.success, this.historical,
      this.date, this.timestamp, this.source, this.quotes);

  factory HistoricalCurrencyRes.fromJson(Map<String, dynamic> json) => _$HistoricalCurrencyResFromJson(json);
  Map<String, dynamic> toJson() => _$HistoricalCurrencyResToJson(this);
}