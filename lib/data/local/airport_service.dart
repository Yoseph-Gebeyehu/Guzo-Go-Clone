import 'package:guzo_go_clone/data/local/sqflight_local_db.dart';
import 'package:guzo_go_clone/data/model/Airport.dart';
import 'package:sqflite/sqflite.dart' as sql;
import '/domain/constants/app_database_tables.dart';

class AirportService {
  Future<void> addStartingAirportToDB(Airport airport) async {
    Map<String, dynamic> data = airport.toJson();
    sql.Database db = await SQLDatabaseService.openDatabase();
    await db.insert(
      AppDatabaseTables.startingAirport,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<List<Airport>> getStartingAirportsFromDB() async {
    List<Airport> airports = [];
    sql.Database db = await SQLDatabaseService.openDatabase();
    var result = await db.query(AppDatabaseTables.startingAirport);
    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        airports.add(Airport.fromJson(result[i]));
      }
    }
    return airports;
  }

  Future<void> updateStartingAirportByCity(
      String city, Airport updatedAirport) async {
    sql.Database db = await SQLDatabaseService.openDatabase();
    await db.update(
      AppDatabaseTables.startingAirport,
      updatedAirport.toJson(),
      where: 'City = ?',
      whereArgs: [city],
    );
  }

  Future<void> clearAirports() async {
    sql.Database db = await SQLDatabaseService.openDatabase();
    await db.delete(AppDatabaseTables.startingAirport);
  }

  Future<void> addDestinationAirportToDB(Airport airport) async {
    Map<String, dynamic> data = airport.toJson();
    sql.Database db = await SQLDatabaseService.openDatabase();
    await db.insert(
      AppDatabaseTables.destinationAirport,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<List<Airport>> getDestinationAirportsFromDB() async {
    List<Airport> airports = [];
    sql.Database db = await SQLDatabaseService.openDatabase();
    var result = await db.query(AppDatabaseTables.destinationAirport);
    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        airports.add(Airport.fromJson(result[i]));
      }
    }
    return airports;
  }

  Future<void> updateDestinationAirportByCity(
      String city, Airport updatedAirport) async {
    sql.Database db = await SQLDatabaseService.openDatabase();
    await db.update(
      AppDatabaseTables.destinationAirport,
      updatedAirport.toJson(),
      where: 'City = ?',
      whereArgs: [city],
    );
  }
}
