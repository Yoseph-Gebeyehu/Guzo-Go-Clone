import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/model/Airport.dart';
import 'package:guzo_go_clone/presentation/airport/screen/select_airport_page.dart';

// ignore: must_be_immutable
class LocationWidget extends StatelessWidget {
  LocationWidget({
    super.key,
    required this.deviceSize,
    required this.startingAirport,
    required this.destinationAirport,
  });
  Size deviceSize;
  Airport startingAirport;
  Airport destinationAirport;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectAirportPage(start: true),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'From',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    startingAirport.shortCode,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    startingAirport.city,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    startingAirport.airportName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const Icon(
            Icons.swap_horiz,
            color: Colors.white,
            size: 30,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectAirportPage(start: false),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  destinationAirport.airportName.isEmpty
                      ? const Column(
                          children: [
                            Text(
                              'To',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Select Destination',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const Text(
                              'To',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              destinationAirport.shortCode,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              destinationAirport.city,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            Text(
                              destinationAirport.airportName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                          ],
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
