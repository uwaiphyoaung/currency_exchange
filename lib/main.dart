import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:wm_cc/convert/bloc/currency_converter_bloc.dart';
import 'package:wm_cc/currency/bloc/currency_list_bloc.dart';
import 'package:wm_cc/live/bloc/live_rate_bloc.dart';
import 'general/bloc/simple_bloc_observer.dart';
import 'home/home_screen.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () => runApp(const MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CurrencyListBloc>(
            create: (BuildContext context) => CurrencyListBloc()..add(FetchCurrencyList()),
          ),
          BlocProvider<LiveRateBloc>(
            create: (BuildContext context) => LiveRateBloc(),
          ),
          BlocProvider<CurrencyConverterBloc>(
            create: (BuildContext context) => CurrencyConverterBloc(),
          ),
        ],
        child: Sizer(
            builder: (context, orientation, deviceType) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Currency Converter',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: HomeScreen(),
              );
            }
        ));
  }
}