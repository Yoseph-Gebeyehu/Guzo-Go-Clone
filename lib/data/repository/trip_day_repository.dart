import 'package:guzo_go_clone/data/model/trip_date.dart';

abstract class TripDateRepository {
  Future<void> addDepartureDateToDB({required TripDate tripDate});
  Future<List<TripDate>> getDepartureDatesFromDB();
  Future<void> updateDepartureDateFromDB({
    required String day,
    required TripDate tripDate,
  });
  Future<void> clearDepartureDates();

  Future<void> addReturnDateToDB({required TripDate tripDate});
  Future<List<TripDate>> getReturnDatesFromDB();
  Future<void> updateReturnDateFromDB({
    required String day,
    required TripDate tripDate,
  });
  Future<void> clearReturnDates();
}
