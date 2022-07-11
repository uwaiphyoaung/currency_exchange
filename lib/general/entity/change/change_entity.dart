import 'package:json_annotation/json_annotation.dart';
part 'change_entity.g.dart';

@JsonSerializable()
class ChangesByPeriodRes{
  late bool success;
  late bool change;
  late String start_date;
  late String end_date;
  late String source;
  late Map<String, dynamic> quotes;

  ChangesByPeriodRes(this.success, this.change,
      this.start_date, this.end_date, this.source, this.quotes);

  factory ChangesByPeriodRes.fromJson(Map<String, dynamic> json) => _$ChangesByPeriodResFromJson(json);
  Map<String, dynamic> toJson() => _$ChangesByPeriodResToJson(this);
}