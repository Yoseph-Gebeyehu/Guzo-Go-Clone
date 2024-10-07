import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/local/passenger_service.dart';
import 'package:guzo_go_clone/data/model/passengers.dart';
import 'package:guzo_go_clone/data/repository/passenger_repository.dart';

class PassengerRepositoryImpl implements PassengerRepository {
  PassengerService passengerService = PassengerService();
  BuildContext context;
  PassengerRepositoryImpl({required this.context});

  @override
  Future<void> addPassenger(Passengers passenger) async {
    await passengerService.addPassengerToDB(passenger);
  }

  @override
  Future<void> updatePassenger(
      String passengerAdult, Passengers passenger) async {
    await passengerService.updatePassengerInDB(passengerAdult, passenger);
  }

  @override
  Future<List<Passengers>> getPassengers() async {
    return await passengerService.getPassengerFromDB();
  }
}
