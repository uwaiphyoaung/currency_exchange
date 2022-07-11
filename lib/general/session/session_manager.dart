import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _LASTCHOOSECURRENCYRATE = "last_choose_currency_rate";
  static const String _LASTCHOOSECURRENCYDESC = "last_choose_currency_desc";
  static const String _LASTCHOOSEDATERATE = "last_choose_date_rate";
  static const String _LASTCONVERTDATE = "last_convert_date";
  static const String _LASTSYNCTIMESTAMP = "last_sync_time";

  static SessionManager? _instance;
  static SharedPreferences? _preferences;

  static SessionManager getInstance() {
    if (_instance == null || _preferences == null) {
      _instance = SessionManager();
      initSession();
    }
    return _instance!;
  }

  static initSession() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setLastChooseCurrencyRate(String key) async {
    _preferences ?? await initSession();
    _preferences!.setString(_LASTCHOOSECURRENCYRATE, key);
  }

  String getLastChooseCurrencyRate() => _preferences?.getString(_LASTCHOOSECURRENCYRATE) ?? "USD";

  Future<void> setLastChooseDateRate(String key) async {
    _preferences ?? await initSession();
    _preferences!.setString(_LASTCHOOSEDATERATE, key);
  }

  String getLastChooseDateRate() => _preferences?.getString(_LASTCHOOSEDATERATE) ?? "Today";

  Future<void> setLastChooseCurrencyDesc(String key) async {
    _preferences ?? await initSession();
    _preferences!.setString(_LASTCHOOSECURRENCYDESC, key);
  }

  String getLastChooseCurrencyDesc() => _preferences?.getString(_LASTCHOOSECURRENCYDESC) ?? "United States Dollar";

  Future<void> setLastConvertDate(String key) async {
    _preferences ?? await initSession();
    _preferences!.setString(_LASTCONVERTDATE, key);
  }

  String getLastConvertDate() => _preferences?.getString(_LASTCONVERTDATE) ?? "Today";

  Future<void> setLastFetchDate(String key) async {
    _preferences ?? await initSession();
    _preferences!.setString("fetch_date", key);
  }

  String getLastFetchDate() => _preferences?.getString("fetch_date") ?? "0";

}