
import 'package:sqflite/sql.dart';

import '../app_database.dart';

class RatesEntity{
  int? id;
  late String name;
  late String value;
  late String date;
  late String source;
  late int timestamp;

  static const String TABLE_NAME = "rates_table";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_VALUE = "value";
  static const String COLUMN_DATE = "date";
  static const String COLUMN_SOURCE = "source";
  static const String COLUMN_TIMESTAMP = "timestamp";

  RatesEntity({this.id,
    required this.name,
    required this.value,
    required this.date,
    required this.source,
    required this.timestamp});

  Map<String, dynamic> toDbJson() {
    final _data = <String, dynamic>{};
    _data[COLUMN_ID] = id;
    _data[COLUMN_NAME] = name;
    _data[COLUMN_VALUE] = value;
    _data[COLUMN_DATE] = date;
    _data[COLUMN_SOURCE] = source;
    _data[COLUMN_TIMESTAMP] = timestamp;
    return _data;
  }

  RatesEntity.fromMap(
      Map<String, dynamic> map)
      : id = map[COLUMN_ID] as int,
        name = map[COLUMN_NAME] as String,
        value = map[COLUMN_VALUE] as String,
        date = map[COLUMN_DATE] as String,
        source = map[COLUMN_SOURCE] as String,
        timestamp = map[COLUMN_TIMESTAMP] as int;

  RatesEntity.empty()
      : id = 0, name = "", value = "", date = "", source = "", timestamp = 0;
}

class RatesDao {
  final dbProvider = DatabaseProvider.dbProvider;

  add(RatesEntity data) async {
    final db = await dbProvider.database;
    db.insert(RatesEntity.TABLE_NAME, data.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<void> addAll(Map<String, num> rates,{
        required String date,
        required int timestamp,
        required String source}) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    rates.entries.forEach((e) {
      batch.insert(RatesEntity.TABLE_NAME, {
        RatesEntity.COLUMN_NAME: e.key,
        RatesEntity.COLUMN_VALUE: e.value,
        RatesEntity.COLUMN_DATE: date,
        RatesEntity.COLUMN_TIMESTAMP: timestamp,
        RatesEntity.COLUMN_SOURCE: source,
      });
    });
    await batch.commit();
  }

  Future<void> deleteByFilter({
    required String name,
    required String date,
    required int timestamp,
    required String source}) async {
    final db = await dbProvider.database;
    await db.delete(
        RatesEntity.TABLE_NAME,
        where: '${RatesEntity.COLUMN_NAME} = ? and ${RatesEntity.COLUMN_DATE} = ? and ${RatesEntity.COLUMN_TIMESTAMP} = ? and ${RatesEntity.COLUMN_SOURCE} = ?',
        whereArgs: [name, date, timestamp, source]);
  }

  deleteAll() async {
    var db = await dbProvider.database;
    db.delete(RatesEntity.TABLE_NAME);
  }

  Future<List<RatesEntity>> getAllItems() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM ${RatesEntity.TABLE_NAME} ORDER BY ${RatesEntity.COLUMN_NAME}');
    return List.generate(maps.length, (i) {
      return RatesEntity(
        id: maps[i][RatesEntity.COLUMN_ID],
        value: maps[i][RatesEntity.COLUMN_VALUE],
        name: maps[i][RatesEntity.COLUMN_NAME],
        date: maps[i][RatesEntity.COLUMN_DATE],
        source: maps[i][RatesEntity.COLUMN_SOURCE],
        timestamp: maps[i][RatesEntity.COLUMN_TIMESTAMP],
      );
    });
  }

  Future<List<RatesEntity>> getFilter({
    required String date,
    required String source}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> maps = await db.query(RatesEntity.TABLE_NAME,
        columns: [
          RatesEntity.COLUMN_ID,
          RatesEntity.COLUMN_VALUE,
          RatesEntity.COLUMN_NAME,
          RatesEntity.COLUMN_DATE,
          RatesEntity.COLUMN_SOURCE,
          RatesEntity.COLUMN_TIMESTAMP
        ],
        where: '${RatesEntity.COLUMN_DATE} = ? and ${RatesEntity.COLUMN_SOURCE} = ?',
        whereArgs: [date, source]);
    return List.generate(maps.length, (i) {
      return RatesEntity(
        id: maps[i][RatesEntity.COLUMN_ID],
        name: maps[i][RatesEntity.COLUMN_NAME],
        value: maps[i][RatesEntity.COLUMN_VALUE],
        date: maps[i][RatesEntity.COLUMN_DATE],
        source: maps[i][RatesEntity.COLUMN_SOURCE],
        timestamp: maps[i][RatesEntity.COLUMN_TIMESTAMP],
      );
    });
  }


  Future<RatesEntity> getRateByCode(String code) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> maps = await db.query(RatesEntity.TABLE_NAME,
        columns: [
          RatesEntity.COLUMN_ID,
          RatesEntity.COLUMN_NAME,
          RatesEntity.COLUMN_VALUE,
          RatesEntity.COLUMN_DATE,
          RatesEntity.COLUMN_SOURCE,
          RatesEntity.COLUMN_TIMESTAMP
        ],
        where: '${RatesEntity.COLUMN_NAME} = ?',
        whereArgs: [code]);
    Map<String, dynamic> myRows = {};
    for (var row in maps) {
      myRows = row;
    }
    if(myRows.isNotEmpty) {
      return RatesEntity.fromMap(myRows);
    }else{
      return RatesEntity.empty();
    }
  }
}