class Env {
  final String apiBaseUrl;
  final String apiAccessKey;
  final int apiRefreshTime;
  Env({
    required this.apiBaseUrl,
    required this.apiAccessKey,
    required this.apiRefreshTime,
  });
}

class EnvValue {
  static final Env dev = Env(
    apiBaseUrl: 'https://api.apilayer.com/currency_data',
    apiAccessKey: 'dChH4kOF9ERWyAH3nkJo6q8QcYwlKjyW',
    apiRefreshTime: 30
  );
}