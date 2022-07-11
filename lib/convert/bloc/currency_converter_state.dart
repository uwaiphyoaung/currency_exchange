part of 'currency_converter_bloc.dart';

enum ConverterStatus { initial, success, servererror, interneterror, reset }

class ConverterState{

  final ConverterStatus status;
  final bool fail;
  final List<ConvertItemModel> data;
  ConverterState({
    this.status = ConverterStatus.initial,
    this.fail = false,
    this.data = const[]
  });

  ConverterState copyWith({
    ConverterStatus? status,
    bool? fail,
    List<ConvertItemModel>? data,
  }) {
    return ConverterState(
        status: status ?? this.status,
        fail: fail?? this.fail,
        data: data ?? this.data
    );
  }
}

