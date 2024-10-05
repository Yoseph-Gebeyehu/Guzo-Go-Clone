import 'package:guzo_go_clone/domain/constants/app_database_tables.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class SQLDatabaseService {
  static String dataBaseName = "chapa.db";
  static String databasePath = "";

  static getDatabasePath() async {
    var dbPath = await sql.getDatabasesPath();
    databasePath = path.join(dbPath, dataBaseName);
    return databasePath;
  }

  static Future<Database> openDatabase() async {
    final dbPath = await getDatabasePath();
    return await sql.openDatabase(
      dbPath,
      version: 5,
      onCreate: (Database db, int version) async {
        await db.execute('''
    CREATE TABLE ${AppDatabaseTables.startingAirport} (
      City TEXT,
      AirportName TEXT, 
      ShortCode TEXT
      )
      ''');
        await db.execute('''
    CREATE TABLE ${AppDatabaseTables.destinationAirport} (
      City TEXT,
      AirportName TEXT, 
      ShortCode TEXT
      )
      ''');
      },
    );
  }

  deleteDatabase() async {
    String dbPath = await getDatabasePath();
    await clearAllTables();
    return await sql.deleteDatabase(dbPath);
  }

  Future<bool> clearAllTables() async {
    try {
      final db = await openDatabase();
      final tables = [
        AppDatabaseTables.startingAirport,
        AppDatabaseTables.destinationAirport,
      ];
      for (final table in tables) {
        await db.delete(table);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
