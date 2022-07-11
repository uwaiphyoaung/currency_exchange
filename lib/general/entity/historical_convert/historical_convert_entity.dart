import 'package:json_annotation/json_annotation.dart';

import '../convert/convert_entity.dart';
part 'historical_convert_entity.g.dart';

@JsonSerializable()
class HistoricalConvertRes{
  late QueryData query;
  late InfoData info;
  late bool success;
  late bool historical;
  late String date;
  late num result;


  HistoricalConvertRes(this.query, this.info, this.success,
      this.historical, this.date, this.result);

  factory HistoricalConvertRes.fromJson(Map<String, dynamic> json) => _$HistoricalConvertResFromJson(json);
  Map<String, dynamic> toJson() => _$HistoricalConvertResToJson(this);
}