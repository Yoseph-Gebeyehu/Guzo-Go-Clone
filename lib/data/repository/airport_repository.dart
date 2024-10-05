import 'package:guzo_go_clone/data/model/Airport.dart';

abstract class AirportRepository {
  Future<List<Airport>> getAirportList();
  Future addStartingAirportToDB({required Airport airport});
  Future<List<Airport>> getStartingAirportFromDB();
  Future updateStartingAirportFromDB(
      {required String city, required Airport airport});

  Future<void> addDestinationAirportToDB({required Airport airport});
  Future<List<Airport>> getDestinationAirportsFromDB();
  Future<void> updateDestinationAirportFromDB(
      {required String city, required Airport airport});
}
