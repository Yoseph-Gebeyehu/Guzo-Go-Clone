import 'package:guzo_go_clone/data/local/sqflight_local_db.dart';
import 'package:guzo_go_clone/data/model/cabin_class.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../../domain/constants/app_database_tables.dart';

class CabinClassService {
  // Method to add a new cabin class to the database
  Future<void> addCabinClassToDB(CabinClass cabinClass) async {
    Map<String, dynamic> data = cabinClass.toJson();
    sql.Database db = await SQLDatabaseService.openDatabase();

    if (cabinClass.cabinClass.isNotEmpty) {
      await db.insert(
        AppDatabaseTables.cabinClass,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    } else {
      throw Exception("Cabin class name cannot be empty.");
    }
  }

  // Method to update an existing cabin class in the database
  Future<void> updateCabinClassInDB(String cabin, CabinClass cabinClass) async {
    Map<String, dynamic> data = cabinClass.toJson();
    sql.Database db = await SQLDatabaseService.openDatabase();

    if (cabinClass.cabinClass.isNotEmpty) {
      await db.update(
        AppDatabaseTables.cabinClass,
        data,
        where: 'cabinClass = ?',
        whereArgs: [cabin],
      );
    } else {
      throw Exception("Cabin class name cannot be empty.");
    }
  }

  // Method to retrieve cabin classes from the database
  Future<List<CabinClass>> getCabinClassFromDB() async {
    List<CabinClass> cabinClasses = [];
    sql.Database db = await SQLDatabaseService.openDatabase();

    var result = await db.query(AppDatabaseTables.cabinClass);
    if (result.isNotEmpty) {
      for (var item in result) {
        cabinClasses.add(CabinClass.fromJson(item));
      }
    }
    return cabinClasses;
  }
}
