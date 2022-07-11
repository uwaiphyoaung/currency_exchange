
import 'package:json_annotation/json_annotation.dart';
part 'currency_list_entity.g.dart';

@JsonSerializable()
class CurrencyListRes{
  late bool success;
  late Map<String, String> currencies;

  CurrencyListRes(this.success, this.currencies);

  factory CurrencyListRes.fromJson(Map<String, dynamic> json) => _$CurrencyListResFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyListResToJson(this);
}