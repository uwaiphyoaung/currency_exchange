import 'package:json_annotation/json_annotation.dart';
part 'time_frame_entity.g.dart';

@JsonSerializable()
class RatesByPeriodRes{
  late bool success;
  late bool timeframe;
  late String start_date;
  late String end_date;
  late String source;
  late Map<String, dynamic> quotes;

  RatesByPeriodRes(this.success, this.timeframe,
      this.start_date, this.end_date, this.source, this.quotes);

  factory RatesByPeriodRes.fromJson(Map<String, dynamic> json) => _$RatesByPeriodResFromJson(json);
  Map<String, dynamic> toJson() => _$RatesByPeriodResToJson(this);
}