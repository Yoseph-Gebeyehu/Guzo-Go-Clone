import 'package:guzo_go_clone/data/local/sqflight_local_db.dart';
import 'package:guzo_go_clone/data/model/passengers.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../../domain/constants/app_database_tables.dart';

class PassengerService {
  Future<void> addPassengerToDB(Passengers passengers) async {
    Map<String, dynamic> data = passengers.toJson();
    sql.Database db = await SQLDatabaseService.openDatabase();

    await db.insert(
      AppDatabaseTables.passenger,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<void> updatePassengerInDB(
      String passengerAdult, Passengers passenger) async {
    Map<String, dynamic> data = passenger.toJson();
    sql.Database db = await SQLDatabaseService.openDatabase();

    await db.update(
      AppDatabaseTables.passenger,
      data,
      where: 'adult = ?',
      whereArgs: [passengerAdult],
    );
  }

  Future<List<Passengers>> getPassengerFromDB() async {
    List<Passengers> passengers = [];
    sql.Database db = await SQLDatabaseService.openDatabase();

    var result = await db.query(AppDatabaseTables.passenger);
    if (result.isNotEmpty) {
      for (var item in result) {
        passengers.add(Passengers.fromJson(item));
      }
    }
    return passengers;
  }
}
