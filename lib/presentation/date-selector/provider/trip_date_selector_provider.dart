import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/model/trip_date.dart';
import 'package:guzo_go_clone/data/repository/impl/trip_day_repositoryImpl.dart';
import 'package:guzo_go_clone/data/repository/trip_day_repository.dart';
import 'package:guzo_go_clone/presentation/home/screen/home.dart';

class TripDateProvider with ChangeNotifier {
  BuildContext context;
  bool isLoading = false;

  TripDateProvider({required this.context});
  Future<void> addTripDates(
    TripDate departureDate,
    TripDate returnDate,
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      TripDateRepository tripDateRepository = TripDateRepositoryImpl(
        context: context,
      );
      List<TripDate> departureListFromDB =
          await tripDateRepository.getDepartureDatesFromDB();
      List<TripDate> returnListFromDB =
          await tripDateRepository.getReturnDatesFromDB();
      if (departureListFromDB.isEmpty && returnListFromDB.isEmpty) {
        await tripDateRepository.addDepartureDateToDB(tripDate: departureDate);
        await tripDateRepository.addReturnDateToDB(tripDate: returnDate);
      } else {
        await tripDateRepository.updateDepartureDateFromDB(
          day: departureListFromDB[0].day,
          tripDate: departureDate,
        );
        await tripDateRepository.updateReturnDateFromDB(
          day: returnListFromDB[0].day,
          tripDate: returnDate,
        );
      }
      isLoading = false;

      notifyListeners();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      print('Error adding trip dates: $error');
    }
  }
}
