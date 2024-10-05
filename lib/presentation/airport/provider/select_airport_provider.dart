import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guzo_go_clone/data/repository/airport_repository.dart';
import 'package:guzo_go_clone/data/repository/impl/airport_repositoryImpl.dart';
import 'package:guzo_go_clone/presentation/home/screen/home.dart';
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
      fetchAirports();
    });

    if (filteredAirports.isEmpty) {
      isLoading = false;
      notifyListeners();
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

  Future<void> addStartingAirportToDB({
    required Airport airport,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      AirportRepository airportRepository =
          AirportRepositoryimpl(context: context);
      List<Airport> listFromDB =
          await airportRepository.getStartingAirportFromDB();
      if (listFromDB.isEmpty) {
        await airportRepository.addStartingAirportToDB(airport: airport);
      } else {
        await airportRepository.updateStartingAirportFromDB(
          city: listFromDB[0].city,
          airport: airport,
        );
      }
      isLoading = false;
      notifyListeners();
      if (isLoading == false) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } catch (error) {
      print('$error');
    } finally {}
  }

  Future<void> addDestinationAirportToDB({
    required Airport airport,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      AirportRepository airportRepository =
          AirportRepositoryimpl(context: context);
      List<Airport> listFromDB =
          await airportRepository.getDestinationAirportsFromDB();
      if (listFromDB.isEmpty) {
        await airportRepository.addDestinationAirportToDB(airport: airport);
      } else {
        await airportRepository.updateDestinationAirportFromDB(
          city: listFromDB[0].city,
          airport: airport,
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
      print('$error');
    } finally {}
  }
}
