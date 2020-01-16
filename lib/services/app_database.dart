import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:rockband_weather_app/models/current/current_sqlite_model.dart';
import 'package:rockband_weather_app/models/forecast/forecast_sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';

class AppDatabase {
  final _lock = new Lock();

  ///Singleton, calling it more than once with result in the same
  ///instance of [AppDatabase]
  static final AppDatabase _appDatabase = new AppDatabase._internal();

  AppDatabase._internal();

  Database _database;

  static AppDatabase get() {
    return _appDatabase;
  }

  /// If a call is made to get the [Database]
  /// we check if it is null or closed.
  /// we lock the call in case lot's of calls are
  /// made to this function
  Future<Database> getDb() async {
    if (_database == null || !_database.isOpen) {
      await _lock.synchronized(() async {
        if (_database == null) {
          await this._init();
        }
      });
    }
    return _database;
  }

  /// private initiation of the db. We create or get the database file
  /// called [weather.db] and perform the drop if Exists action when it's
  /// created, also perform the _createTables method
  Future<void> _init() async {
    final List<String> tablesList = [
      CurrentSQLiteModel.TABLE,
      ForecastSQLiteModel.TABLE
    ];

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "weather.db");

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await _dropTablesIfExists(tablesList, db);

      await _createTables(db);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {});
  }

  Future<void> _createTables(Database db) async {
    await CurrentSQLiteModel.createTable(db);
    await ForecastSQLiteModel.createTable(db);
  }

  Future<void> _dropTablesIfExists(List<String> tablesList, Database db) async {
    for (var table in tablesList) {
      print('dropping table: $table');
      await db.execute("DROP TABLE IF EXISTS $table;");
    }
  }
}
