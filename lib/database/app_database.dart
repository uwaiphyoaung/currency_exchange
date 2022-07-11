import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wm_cc/database/dao/currency_dao.dart';
import 'package:wm_cc/database/dao/rates_dao.dart';
import 'package:wm_cc/database/dao/saved_currency_dao.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;

  Future<Database> get database async {
    _database ??= await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    var database = await openDatabase(join(dbPath, "cc_db"),
        version: 1,
        onCreate: initDB,
        onUpgrade: onUpgrade,
        onDowngrade: onDatabaseDowngradeDelete);
    return database;
  }

  void onUpgrade(
      Database database,
      int oldVersion,
      int newVersion,
      ) {
    if (newVersion > oldVersion) {
      //Do something
    }
  }

  void initDB(Database database, int version) async {
    //Dropping tables
    await database.execute('DROP TABLE IF EXISTS ${CurrencyEntity.TABLE_NAME}');
    await database.execute('DROP TABLE IF EXISTS ${RatesEntity.TABLE_NAME}');
    await database.execute('DROP TABLE IF EXISTS ${SavedCurrencyDao.TABLE_NAME}');
    //create tables
    createCurrencyTable(database);
    createRatesTable(database);
    createSavedCurrencyTable(database);
  }

  void createCurrencyTable(Database database) async {
    await database.execute("CREATE TABLE IF NOT EXISTS ${CurrencyEntity.TABLE_NAME} ("
        "${CurrencyEntity.COLUMN_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${CurrencyEntity.COLUMN_NAME} TEXT,"
        "${CurrencyEntity.COLUMN_VALUE} TEXT"
        ")");
  }

  void createSavedCurrencyTable(Database database) async {
    await database.execute("CREATE TABLE IF NOT EXISTS ${SavedCurrencyDao.TABLE_NAME} ("
        "${CurrencyEntity.COLUMN_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${CurrencyEntity.COLUMN_NAME} TEXT,"
        "${CurrencyEntity.COLUMN_VALUE} TEXT"
        ")");
  }

  void createRatesTable(Database database) async {
    await database.execute("CREATE TABLE IF NOT EXISTS ${RatesEntity.TABLE_NAME} ("
        "${RatesEntity.COLUMN_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${RatesEntity.COLUMN_NAME} TEXT,"
        "${RatesEntity.COLUMN_VALUE} TEXT,"
        "${RatesEntity.COLUMN_DATE} TEXT,"
        "${RatesEntity.COLUMN_SOURCE} TEXT,"
        "${RatesEntity.COLUMN_TIMESTAMP} INTEGER"
        ")");
  }
}
