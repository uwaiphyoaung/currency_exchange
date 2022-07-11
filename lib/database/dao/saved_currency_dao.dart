import 'package:sqflite/sql.dart';

import '../app_database.dart';
import 'currency_dao.dart';

class SavedCurrencyDao {
  static const String TABLE_NAME = "saved_currency_table";
  final dbProvider = DatabaseProvider.dbProvider;

  add(CurrencyEntity data) async {
    final db = await dbProvider.database;
    db.delete(SavedCurrencyDao.TABLE_NAME, where: '${CurrencyEntity.COLUMN_NAME} = ?', whereArgs: [data.name]);
    db.insert(SavedCurrencyDao.TABLE_NAME, data.toDbJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> addAll(Map<String, String> currencies) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    currencies.entries.forEach((e) {
      batch.insert(SavedCurrencyDao.TABLE_NAME, {
        CurrencyEntity.COLUMN_NAME: e.key,
        CurrencyEntity.COLUMN_VALUE: e.value,
      });
    });
    await batch.commit();
  }

  deleteAll() async {
    var db = await dbProvider.database;
    db.delete(SavedCurrencyDao.TABLE_NAME);
  }

  Future<void> replaceAll(Map<String, String> currencies) async {
    final db = await dbProvider.database;
    db.delete(SavedCurrencyDao.TABLE_NAME);
    await addAll(currencies);
  }

  Future<List<CurrencyEntity>> getAllCurrencies() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM ${SavedCurrencyDao.TABLE_NAME} ORDER BY ${CurrencyEntity.COLUMN_NAME}');
    return List.generate(maps.length, (i) {
      return CurrencyEntity(
        id: maps[i][CurrencyEntity.COLUMN_ID],
        value: maps[i][CurrencyEntity.COLUMN_VALUE],
        name: maps[i][CurrencyEntity.COLUMN_NAME],
      );
    });
  }

  Future<List<CurrencyEntity>> getCurrencies(List<String> codes) async {
    final db = await dbProvider.database;
    final maps = await db.query(
      SavedCurrencyDao.TABLE_NAME,
      where: "${CurrencyEntity.COLUMN_VALUE} IN (${codes.map((_) => '?').join(', ')})",
      whereArgs: codes,
    );
    return maps.map((e) => CurrencyEntity.fromMap(e)).toList();
  }

  Future<List<Map<String, dynamic>>> getSortedCurrencies() async {
    final db = await dbProvider.database;
    return db.rawQuery(''
        'SELECT * FROM ${SavedCurrencyDao.TABLE_NAME} '
        'ORDER BY ${CurrencyEntity.COLUMN_NAME}');
  }
}