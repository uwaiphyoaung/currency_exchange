import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

class SessionManager {
  static const String _LASTCHOOSECURRENCYRATE = "last_choose_currency_rate";
  static const String _LASTCHOOSECURRENCYDESC = "last_choose_currency_desc";
  static const String _LASTCHOOSEDATERATE = "last_choose_date_rate";
  static const String _LASTCONVERTDATE = "last_convert_date";
  static const String _LASTSYNCTIMESTAMP = "last_sync_time";

  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static void setLastChooseCurrencyRate(String key) async {
    await instance.setString(_LASTCHOOSECURRENCYRATE, key);
  }

  static String getLastChooseCurrencyRate() => instance.getString(_LASTCHOOSECURRENCYRATE) ?? "USD";

  static void setLastChooseDateRate(String key) async {
    instance.setString(_LASTCHOOSEDATERATE, key);
  }

  static String getLastChooseDateRate() => instance.getString(_LASTCHOOSEDATERATE) ?? "Today";

  static void setLastChooseCurrencyDesc(String key) async {
    await instance.setString(_LASTCHOOSECURRENCYDESC, key);
  }

  static String getLastChooseCurrencyDesc() => instance.getString(_LASTCHOOSECURRENCYDESC) ?? "United States Dollar";

  static void setLastConvertDate(String key) async {
    await instance.setString(_LASTCONVERTDATE, key);
  }

  static String getLastConvertDate() => instance.getString(_LASTCONVERTDATE) ?? "Today";

  static void setLastFetchDate(String key) async {
    await instance.setString("fetch_date", key);
  }

  static String getLastFetchDate() => instance.getString("fetch_date") ?? "0";

}