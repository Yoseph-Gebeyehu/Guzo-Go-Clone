import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/model/Airport.dart';
import 'package:guzo_go_clone/data/repository/airport_repository.dart';
import 'package:guzo_go_clone/domain/constants/app_constants.dart';

class AirportRepositoryimpl extends AirportRepository {
  BuildContext context;
  List<Airport> airports = [];

  AirportRepositoryimpl({required this.context});
  @override
  Future<List<Airport>> getAirportList() async {
    final String response =
        await DefaultAssetBundle.of(context).loadString(AppConstants.baseUrl);

    final List<dynamic> jsonData = json.decode(response);
    airports = jsonData.map((json) => Airport.fromJson(json)).toList();
    return airports;
  }
}
