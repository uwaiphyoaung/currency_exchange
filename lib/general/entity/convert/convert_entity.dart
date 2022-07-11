import 'package:json_annotation/json_annotation.dart';
part 'convert_entity.g.dart';

@JsonSerializable()
class InfoData{
  late int timestamp;
  late num quote;

  InfoData(this.timestamp, this.quote);
  factory InfoData.fromJson(Map<String, dynamic> json) => _$InfoDataFromJson(json);
  Map<String, dynamic> toJson() => _$InfoDataToJson(this);
}

@JsonSerializable()
class QueryData{
  late String from;
  late String to;
  late num amount;

  QueryData(this.from, this.to, this.amount);

  factory QueryData.fromJson(Map<String, dynamic> json) => _$QueryDataFromJson(json);
  Map<String, dynamic> toJson() => _$QueryDataToJson(this);
}

@JsonSerializable()
class ConvertRes{
  late QueryData query;
  late InfoData info;
  late bool success;
  late num result;

  ConvertRes(this.query, this.info, this.success,
      this.result);

  factory ConvertRes.fromJson(Map<String, dynamic> json) => _$ConvertResFromJson(json);
  Map<String, dynamic> toJson() => _$ConvertResToJson(this);
}