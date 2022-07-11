import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wm_cc/live/bloc/live_rate_bloc.dart';

class LiveRatePresenter{
  void loadRate(BuildContext context,
      {required String source, required String sourceDesc, required String date}) =>
      BlocProvider.of<LiveRateBloc>(context).add(FetchRatesCurrencyAndDate(source:source, date: date, sourceDesc: sourceDesc));
}