import 'package:json_annotation/json_annotation.dart';
part 'live_entity.g.dart';

@JsonSerializable()
class LiveCurrencyRes{
  late bool success;
  late int timestamp;
  late String source;
  late Map<String, num> quotes;

  LiveCurrencyRes(this.success, this.timestamp,
      this.source, this.quotes);

  factory LiveCurrencyRes.fromJson(Map<String, dynamic> json) => _$LiveCurrencyResFromJson(json);
  Map<String, dynamic> toJson() => _$LiveCurrencyResToJson(this);
}