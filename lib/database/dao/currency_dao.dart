import 'package:sqflite/sql.dart';

import '../app_database.dart';

class CurrencyEntity{
  int? id;
  late String name;
  late String value;
  static const String TABLE_NAME = "currency_table";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_VALUE = "value";

  CurrencyEntity({this.id, required this.name, required this.value});

  Map<String, dynamic> toDbJson() {
    final _data = <String, dynamic>{};
    _data[COLUMN_ID] = id;
    _data[COLUMN_NAME] = name;
    _data[COLUMN_VALUE] = value;
    return _data;
  }

  CurrencyEntity.fromMap(
      Map<String, dynamic> map)
      : id = map[COLUMN_ID] as int,
        name = map[COLUMN_NAME] as String,
        value = map[COLUMN_VALUE] as String;

}

class CurrencyDao {
  final dbProvider = DatabaseProvider.dbProvider;

  add(CurrencyEntity data) async {
    final db = await dbProvider.database;
    db.insert(CurrencyEntity.TABLE_NAME, data.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> addAll(Map<String, String> currencies) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    currencies.entries.forEach((e) {
      batch.insert(CurrencyEntity.TABLE_NAME, {
        CurrencyEntity.COLUMN_NAME: e.key,
        CurrencyEntity.COLUMN_VALUE: e.value,
      });
    });
    await batch.commit();
  }

  deleteAll() async {
    var db = await dbProvider.database;
    db.delete(CurrencyEntity.TABLE_NAME);
  }

  Future<void> replaceAll(Map<String, String> currencies) async {
    final db = await dbProvider.database;
    db.delete(CurrencyEntity.TABLE_NAME);
    await addAll(currencies);
  }

  Future<List<CurrencyEntity>> getAllCurrencies() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM ${CurrencyEntity.TABLE_NAME} ORDER BY ${CurrencyEntity.COLUMN_NAME}');
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
      CurrencyEntity.TABLE_NAME,
      where: "${CurrencyEntity.COLUMN_VALUE} IN (${codes.map((_) => '?').join(', ')})",
      whereArgs: codes,
    );
    return maps.map((e) => CurrencyEntity.fromMap(e)).toList();
  }

  Future<List<Map<String, dynamic>>> getSortedCurrencies() async {
    final db = await dbProvider.database;
    return db.rawQuery(''
        'SELECT * FROM ${CurrencyEntity.TABLE_NAME} '
        'ORDER BY ${CurrencyEntity.COLUMN_NAME}');
  }

  String getSearchChar(String s, String content){
    String st = "";
    if (s.contains(" ")) {
      List<String> items = s.split(" ");
      for(int i = 0 ; i<items.length; i++){
        st = "$st$content LIKE '%${items[i]}%' OR ";
      }
    }
    return "$st$content LIKE '%$s%'";
  }


  Future<List<CurrencyEntity>> getSearchCurrency(String data) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM ${CurrencyEntity.TABLE_NAME} WHERE (${getSearchChar(data, "value")}) ORDER BY ${CurrencyEntity.COLUMN_NAME}');
    return List.generate(maps.length, (i) {
      return CurrencyEntity(
        id: maps[i][CurrencyEntity.COLUMN_ID],
        value: maps[i][CurrencyEntity.COLUMN_VALUE],
        name: maps[i][CurrencyEntity.COLUMN_NAME],
      );
    });
  }

  Future<CurrencyEntity> getCurrencyByCode(String code) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> maps = await db.query(CurrencyEntity.TABLE_NAME,
        columns: [
          CurrencyEntity.COLUMN_ID,
          CurrencyEntity.COLUMN_VALUE,
          CurrencyEntity.COLUMN_NAME
        ],
        where: '${CurrencyEntity.COLUMN_NAME} = ?',
        whereArgs: [code]);
    Map<String, dynamic> myRows = {};
    for (var row in maps) {
      myRows = row;
    }
    return CurrencyEntity.fromMap(myRows);
  }
}