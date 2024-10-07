import 'package:guzo_go_clone/data/model/passengers.dart';

abstract class PassengerRepository {
  Future<void> addPassenger(Passengers passenger);
  Future<void> updatePassenger(String passengerAdult, Passengers passenger);
  Future<List<Passengers>> getPassengers();
}
