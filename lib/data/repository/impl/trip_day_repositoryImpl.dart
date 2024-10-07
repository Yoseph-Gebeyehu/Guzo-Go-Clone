import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/local/trip_date_service.dart';
import 'package:guzo_go_clone/data/model/trip_date.dart';

import '../trip_day_repository.dart';

class TripDateRepositoryImpl extends TripDateRepository {
  BuildContext context;
  TripDateService tripDateService = TripDateService();

  TripDateRepositoryImpl({
    required this.context,
  });

  @override
  Future<void> addDepartureDateToDB({required TripDate tripDate}) {
    return tripDateService.addDepartureDateToDB(tripDate);
  }

  @override
  Future<List<TripDate>> getDepartureDatesFromDB() async {
    return await tripDateService.getDepartureDateFromDB();
  }

  @override
  Future<void> updateDepartureDateFromDB(
      {required String day, required TripDate tripDate}) {
    return tripDateService.updateDepartureDateByDay(day, tripDate);
  }

  @override
  Future<void> clearDepartureDates() {
    return tripDateService.clearDepartureDates();
  }

  @override
  Future<void> addReturnDateToDB({required TripDate tripDate}) {
    return tripDateService.addReturnDateToDB(tripDate);
  }

  @override
  Future<List<TripDate>> getReturnDatesFromDB() async {
    return await tripDateService.getReturnDateFromDB();
  }

  @override
  Future<void> updateReturnDateFromDB(
      {required String day, required TripDate tripDate}) {
    return tripDateService.updateReturnDateByDay(day, tripDate);
  }

  @override
  Future<void> clearReturnDates() {
    return tripDateService.clearReturnDates();
  }
}
