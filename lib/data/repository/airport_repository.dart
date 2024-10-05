import 'package:guzo_go_clone/data/model/Airport.dart';

abstract class AirportRepository {
  Future<List<Airport>> getAirportList();
}
