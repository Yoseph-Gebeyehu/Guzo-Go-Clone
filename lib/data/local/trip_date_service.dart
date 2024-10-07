import 'package:guzo_go_clone/data/local/sqflight_local_db.dart';
import 'package:guzo_go_clone/data/model/trip_date.dart';
import 'package:sqflite/sqflite.dart' as sql;
import '/domain/constants/app_database_tables.dart';

class TripDateService {
  Future<void> addDepartureDateToDB(TripDate tripDate) async {
    Map<String, dynamic> data = tripDate.toJson();
    sql.Database db = await SQLDatabaseService.openDatabase();
    await db.insert(
      AppDatabaseTables.departureDate,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<List<TripDate>> getDepartureDateFromDB() async {
    List<TripDate> tripDates = [];
    sql.Database db = await SQLDatabaseService.openDatabase();
    var result = await db.query(AppDatabaseTables.departureDate);
    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        tripDates.add(TripDate.fromJson(result[i]));
      }
    }
    return tripDates;
  }

  Future<void> updateDepartureDateByDay(
      String day, TripDate updatedTripDate) async {
    sql.Database db = await SQLDatabaseService.openDatabase();
    await db.update(
      AppDatabaseTables.departureDate,
      updatedTripDate.toJson(),
      where: 'day = ?',
      whereArgs: [day],
    );
  }

  Future<void> clearDepartureDates() async {
    sql.Database db = await SQLDatabaseService.openDatabase();
    await db.delete(AppDatabaseTables.departureDate);
  }

  Future<void> addReturnDateToDB(TripDate tripDate) async {
    Map<String, dynamic> data = tripDate.toJson();
    sql.Database db = await SQLDatabaseService.openDatabase();
    await db.insert(
      AppDatabaseTables.returnDate,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<List<TripDate>> getReturnDateFromDB() async {
    List<TripDate> tripDates = [];
    sql.Database db = await SQLDatabaseService.openDatabase();
    var result = await db.query(AppDatabaseTables.returnDate);
    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        tripDates.add(TripDate.fromJson(result[i]));
      }
    }
    return tripDates;
  }

  Future<void> updateReturnDateByDay(
      String data, TripDate updatedTripDate) async {
    sql.Database db = await SQLDatabaseService.openDatabase();
    await db.update(
      AppDatabaseTables.returnDate,
      updatedTripDate.toJson(),
      where: 'day = ?',
      whereArgs: [data],
    );
  }

  Future<void> clearReturnDates() async {
    sql.Database db = await SQLDatabaseService.openDatabase();
    await db.delete(AppDatabaseTables.returnDate);
  }
}
