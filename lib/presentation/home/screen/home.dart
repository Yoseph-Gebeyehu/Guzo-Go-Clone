import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/model/cabin_class.dart';
import 'package:guzo_go_clone/data/model/trip_date.dart';
import 'package:guzo_go_clone/presentation/home/provivder/home_provider.dart';
import 'package:guzo_go_clone/presentation/home/widgets/cabin_class_and_passenger.dart';
import 'package:guzo_go_clone/presentation/home/widgets/location.dart';
import 'package:guzo_go_clone/presentation/home/widgets/trip_date_widget.dart';
import 'package:guzo_go_clone/presentation/home/widgets/trip_type.dart';
import 'package:provider/provider.dart';
import 'package:guzo_go_clone/data/model/Airport.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oneWay = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).fetchStartingAirports();
      Provider.of<HomeProvider>(context, listen: false)
          .fetchDestinationAirports();
      Provider.of<HomeProvider>(context, listen: false).fetchDepartureDate();
      Provider.of<HomeProvider>(context, listen: false).fetchReturnDate();
      Provider.of<HomeProvider>(context, listen: false).fetchCabinClasses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);

    List<Airport> startingAirportList = homeProvider.filteredStartingAirports;
    List<Airport> destinationAirportList =
        homeProvider.filteredDestinationAirports;
    TripDate? departureDate = homeProvider.departureDate;
    TripDate? returnDate = homeProvider.returnDate;

    CabinClass? cabinClass = homeProvider.cabinClass;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: deviceSize.height * 0.45,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/plane.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceSize.width * 0.05,
                    vertical: deviceSize.height * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          SizedBox(
                            height: deviceSize.height * 0.1,
                            child: Image.asset('assets/guzo_go.png'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 210, 207, 207),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      TripType(deviceSize: deviceSize, oneWay: oneWay),
                      startingAirportList.isEmpty ||
                              destinationAirportList.isEmpty
                          ? const CircularProgressIndicator()
                          : LocationWidget(
                              startingAirport: startingAirportList[0],
                              destinationAirport: destinationAirportList[0],
                              deviceSize: deviceSize,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          (departureDate == null || returnDate == null)
              ? const CircularProgressIndicator()
              : TripDateWidget(
                  departureDate: departureDate,
                  returnDate: returnDate,
                ),
          cabinClass == null
              ? CabinClassAndPassenger(
                  cabinClass: CabinClass(cabinClass: 'Economy'),
                  homeProvider: homeProvider,
                )
              : CabinClassAndPassenger(
                  cabinClass: cabinClass,
                  homeProvider: homeProvider,
                ),
          const Spacer(),
          SizedBox(
            width: deviceSize.width * 0.8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColorDark,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Search Flights',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: deviceSize.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: deviceSize.height * 0.05),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 35,
                weight: 5,
                color: Theme.of(context).primaryColor,
              ),
              label: 'Search',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Booking',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
