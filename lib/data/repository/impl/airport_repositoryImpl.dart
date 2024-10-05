import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/local/airport_service.dart';
import 'package:guzo_go_clone/data/model/Airport.dart';
import 'package:guzo_go_clone/data/repository/airport_repository.dart';
import 'package:guzo_go_clone/domain/constants/app_constants.dart';

class AirportRepositoryimpl extends AirportRepository {
  BuildContext context;
  List<Airport> airports = [];
  AirportService airportService = AirportService();

  AirportRepositoryimpl({
    required this.context,
  });
  @override
  Future<List<Airport>> getAirportList() async {
    final String response =
        await DefaultAssetBundle.of(context).loadString(AppConstants.baseUrl);

    final List<dynamic> jsonData = json.decode(response);
    airports = jsonData.map((json) => Airport.fromJson(json)).toList();
    return airports;
  }

  @override
  Future addStartingAirportToDB({required Airport airport}) {
    return airportService.addStartingAirportToDB(airport);
  }

  @override
  Future<List<Airport>> getStartingAirportFromDB() async {
    return airportService.getStartingAirportsFromDB();
  }

  @override
  Future updateStartingAirportFromDB(
      {required String city, required Airport airport}) {
    return airportService.updateStartingAirportByCity(city, airport);
  }

  @override
  Future<void> addDestinationAirportToDB({required Airport airport}) {
    return airportService.addDestinationAirportToDB(airport);
  }

  @override
  Future<List<Airport>> getDestinationAirportsFromDB() async {
    return airportService.getDestinationAirportsFromDB();
  }

  @override
  Future<void> updateDestinationAirportFromDB(
      {required String city, required Airport airport}) {
    return airportService.updateDestinationAirportByCity(city, airport);
  }
}
