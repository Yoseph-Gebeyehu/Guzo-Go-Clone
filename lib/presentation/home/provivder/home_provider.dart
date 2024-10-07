import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/model/cabin_class.dart';
import 'package:guzo_go_clone/data/repository/airport_repository.dart';
import 'package:guzo_go_clone/data/repository/impl/airport_repositoryImpl.dart';
import 'package:guzo_go_clone/data/repository/trip_day_repository.dart';
import 'package:guzo_go_clone/data/repository/impl/trip_day_repositoryImpl.dart';
import 'package:intl/intl.dart';
import '../../../data/model/Airport.dart';
import '../../../data/model/trip_date.dart';
import '../../../data/repository/cabin_class_repository.dart';
import '../../../data/repository/impl/cabin_class_repositoryImpl.dart';

class HomeProvider with ChangeNotifier {
  List<Airport> filteredStartingAirports = [];
  List<Airport> filteredDestinationAirports = [];
  List<Airport> startingAirportList = [];
  List<Airport> destinationAirportList = [];

  TripDate? departureDate;
  TripDate? returnDate;

  CabinClass? cabinClass;

  bool isLoading = true;

  BuildContext context;

  HomeProvider({required this.context}) {
    fetchStartingAirports();
    fetchDestinationAirports();
    fetchDepartureDate();
    fetchReturnDate();
    fetchCabinClasses();
  }

  Future<void> fetchStartingAirports() async {
    isLoading = true;
    notifyListeners();

    try {
      AirportRepository airportRepository =
          AirportRepositoryimpl(context: context);
      startingAirportList = await airportRepository.getStartingAirportFromDB();
      if (startingAirportList.isEmpty) {
        startingAirportList = [
          Airport(
            city: 'Addis Ababa',
            airportName: 'Bole International Airport',
            shortCode: 'ADD',
          )
        ];
      }
      filteredStartingAirports = startingAirportList;
    } catch (error) {
      print("Error fetching starting airports: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDestinationAirports() async {
    isLoading = true;
    notifyListeners();

    try {
      AirportRepository airportRepository =
          AirportRepositoryimpl(context: context);
      destinationAirportList =
          await airportRepository.getDestinationAirportsFromDB();
      if (destinationAirportList.isEmpty) {
        destinationAirportList = [
          Airport(
            city: '',
            airportName: '',
            shortCode: '',
          )
        ];
      }
      filteredDestinationAirports = destinationAirportList;
    } catch (error) {
      print("Error fetching destination airports: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDepartureDate() async {
    isLoading = true;
    notifyListeners();

    try {
      TripDateRepository tripDateRepository =
          TripDateRepositoryImpl(context: context);
      List<TripDate> departureDates =
          await tripDateRepository.getDepartureDatesFromDB();
      if (departureDates.isNotEmpty) {
        departureDate = departureDates.first;
      } else {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('dd MMM EEEE').format(now);
        List<String> parts = formattedDate.split(' ');

        departureDate = TripDate(
          day: parts[0],
          month: parts[1],
          date: parts[2],
        );
      }
    } catch (error) {
      print("Error fetching departure date: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchReturnDate() async {
    isLoading = true;
    notifyListeners();

    try {
      TripDateRepository tripDateRepository =
          TripDateRepositoryImpl(context: context);
      List<TripDate> returnDates =
          await tripDateRepository.getReturnDatesFromDB();
      if (returnDates.isNotEmpty) {
        returnDate = returnDates.first;
      } else {
        DateTime now = DateTime.now();
        DateTime returnDateValue = now.add(const Duration(days: 15));
        String formattedDate =
            DateFormat('dd MMM EEEE').format(returnDateValue);
        List<String> parts = formattedDate.split(' ');

        returnDate = TripDate(
          day: parts[0],
          month: parts[1],
          date: parts[2],
        );
      }
    } catch (error) {
      print("Error fetching return date: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCabinClasses() async {
    isLoading = true;
    notifyListeners();

    try {
      CabinClassRepository cabinClassRepository =
          CabinClassRepositoryImpl(context: context);
      var cabin = await cabinClassRepository.getCabinClasses();

      if (cabin.isNotEmpty) {
        cabinClass = cabin.first;
      } else {
        // Set default value if no cabin class is found
        cabinClass = CabinClass(cabinClass: "Economy");
      }
    } catch (error) {
      print("Error fetching cabin classes: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCabinClass(CabinClass cabinClass) async {
    isLoading = true;
    notifyListeners();
    try {
      CabinClassRepository cabinClassRepository =
          CabinClassRepositoryImpl(context: context);
      List<CabinClass> cabinList = await cabinClassRepository.getCabinClasses();
      if (cabinList.isEmpty) {
        await cabinClassRepository.addCabinClass(cabinClass);
      } else {
        await cabinClassRepository.updateCabinClass(
          cabinList[0].cabinClass,
          cabinClass,
        );
      }

      List<CabinClass> checkUp = await cabinClassRepository.getCabinClasses();
      print(checkUp.first.cabinClass);
      isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
