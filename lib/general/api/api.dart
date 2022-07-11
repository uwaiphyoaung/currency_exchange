import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wm_cc/general/entity/convert/convert_entity.dart';
import 'package:wm_cc/general/entity/historical_convert/historical_convert_entity.dart';
import 'package:wm_cc/general/entity/list/currency_list_entity.dart';

import '../entity/historical/historical_entity.dart';
import '../entity/live/live_entity.dart';
import '../entity/time_frame/time_frame_entity.dart';
import '../env.dart';
part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  factory Api.create(
      Env env,
      ) {
    final dio = Dio();
    dio.interceptors.add(AuthInterceptor(env: env));
    return _Api(dio, baseUrl: env.apiBaseUrl);
  }

  @GET("/list")
  Future<CurrencyListRes> getCurrencyList();

  @GET("/live")
  Future<LiveCurrencyRes> getLiveCurrencyDefault();

  @GET("/live")
  Future<LiveCurrencyRes> getLiveCurrencyBySource(@Query("source") String source);

  @GET("/live") /* currencies = AUD,EUR,GBP,PLN*/
  Future<LiveCurrencyRes> getLiveByCurrencies(@Query("currencies") String currencies);

  @GET("/live") /* currencies = AUD,EUR,GBP,PLN*/
  Future<LiveCurrencyRes> getLiveCurrencySearch(@Query("currencies") String currencies, @Query("source") String source);

  @GET("/historical") /*2005-02-01*/
  Future<HistoricalCurrencyRes> getHistoricalRates(@Query("date") String date);

  @GET("/historical") /*2005-02-01*/
  Future<HistoricalCurrencyRes> getHistoricalRatesBySource(@Query("date") String date, @Query("source") String source);

  @GET("/historical") /*2005-02-01*/
  Future<HistoricalCurrencyRes> getHistoricalRatesByCurrency(@Query("date") String date, @Query("currencies") String currencies);

  @GET("/historical") /*2005-02-01*/
  Future<HistoricalCurrencyRes> getHistoricalRatesByCurrencyAndSource(@Query("date") String date, @Query("currencies") String currencies, @Query("source") String source);

  @GET("/convert")
  Future<ConvertRes> covertCurrency(@Query("from") String from, @Query("to") String to, @Query("amount") String amount);

  @GET("/convert")
  Future<HistoricalConvertRes> covertByDate(@Query("from") String from, @Query("to") String to, @Query("amount") String amount, @Query("date") String date);

  @GET("/change")
  Future<RatesByPeriodRes> getChangesByPeriod(@Query("start_date") String start_date, @Query("end_date") String end_date);

  @GET("/change")
  Future<RatesByPeriodRes> getChangesCurrencyByPeriod(@Query("start_date") String start_date, @Query("end_date") String end_date, @Query("currencies") String currencies);

  @GET("/change")
  Future<RatesByPeriodRes> getChangesBySource(@Query("start_date") String start_date, @Query("end_date") String end_date, @Query("source") String source);

  @GET("/change")
  Future<RatesByPeriodRes> getChangesBySourceAndCurrency(@Query("start_date") String start_date, @Query("end_date") String end_date, @Query("currencies") String currencies, @Query("source") String source);

  @GET("/timeframe")
  Future<RatesByPeriodRes> getTimeFrameByCurrency(@Query("start_date") String start_date, @Query("end_date") String end_date, @Query("currencies") String currencies, );

  @GET("/timeframe")
  Future<RatesByPeriodRes> getRatesBySource(@Query("start_date") String start_date, @Query("end_date") String end_date, @Query("source") String source, );

  @GET("/timeframe")
  Future<RatesByPeriodRes> getRatesBySourceAndCurrency(@Query("start_date") String start_date, @Query("end_date") String end_date, @Query("source") String source, @Query("currencies") String currencies );

}


class AuthInterceptor extends InterceptorsWrapper {
  AuthInterceptor({
    required this.env,
  });

  final Env env;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessKey = env.apiAccessKey;
    options.queryParameters.addAll(<String, String>{'apikey': accessKey});
    return handler.next(options);
  }
}