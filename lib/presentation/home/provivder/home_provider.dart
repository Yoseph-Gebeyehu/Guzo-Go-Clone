import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/repository/airport_repository.dart';
import 'package:guzo_go_clone/data/repository/impl/airport_repositoryImpl.dart';
import '../../../data/model/Airport.dart';

class HomeProvider with ChangeNotifier {
  List<Airport> filteredStartingAirports = [];
  List<Airport> filteredDestinationAirports = [];
  List<Airport> startingAirportList = [];
  List<Airport> destinationAirportList = [];
  bool isLoading = true;

  BuildContext context;

  HomeProvider({required this.context}) {
    fetchStartingAirports();
    fetchDestinationAirports();
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
}
