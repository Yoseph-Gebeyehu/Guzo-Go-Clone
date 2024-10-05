import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/repository/airport_repository.dart';
import 'package:guzo_go_clone/data/repository/impl/airport_repositoryImpl.dart';
import '../../../data/model/Airport.dart';

class AirportProvider with ChangeNotifier {
  List<Airport> filteredAirports = [];
  List<Airport> airportList = [];
  bool isLoading = true;

  BuildContext context;

  AirportProvider({required this.context}) {
    fetchAirports();
  }

  Future<void> fetchAirports() async {
    isLoading = true;
    notifyListeners();

    try {
      AirportRepository airportRepository =
          AirportRepositoryimpl(context: context);
      airportList = await airportRepository.getAirportList();
      filteredAirports = airportList;
    } catch (error) {
      // Handle error
      print("Error fetching airports: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> retryFetchAirportsWithDelay() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3), () {
      fetchAirports(); // Re-fetch airports after a delay
    });

    if (filteredAirports.isEmpty) {
      isLoading = false;
      notifyListeners(); // Notify listeners for loading state
    }
  }

  void filterAirports(String query) {
    final List<Airport> results = airportList.where((airport) {
      final airportName = airport.airportName.toLowerCase();
      final cityName = airport.city.toLowerCase();
      final searchQuery = query.toLowerCase();
      return airportName.contains(searchQuery) ||
          cityName.contains(searchQuery);
    }).toList();

    filteredAirports = results;
    notifyListeners();
  }
}
