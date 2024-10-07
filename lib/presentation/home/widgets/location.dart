import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/model/Airport.dart';
import 'package:guzo_go_clone/presentation/airport/screen/select_airport_page.dart';

// ignore: must_be_immutable
class LocationWidget extends StatefulWidget {
  LocationWidget({
    super.key,
    required this.deviceSize,
    required this.startingAirport,
    required this.destinationAirport,
  });

  final Size deviceSize;
  Airport startingAirport;
  Airport destinationAirport;

  @override
  // ignore: library_private_types_in_public_api
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Color startingTextColor = Colors.white;
  Color destinationTextColor = Colors.white;

  void swapAirports() {
    setState(() {
      final temp = widget.startingAirport;
      widget.startingAirport = widget.destinationAirport;
      widget.destinationAirport = temp;
    });
  }

  void changeTextColorOnLongPress({required bool isStarting}) {
    setState(() {
      if (isStarting) {
        startingTextColor = Colors.white24;
      } else {
        destinationTextColor = Colors.white24;
      }
    });
  }

  void resetTextColor({required bool isStarting}) {
    setState(() {
      if (isStarting) {
        startingTextColor = Colors.white;
      } else {
        destinationTextColor = Colors.white;
      }
    });
  }

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
              onLongPress: () {
                changeTextColorOnLongPress(isStarting: true);
              },
              onLongPressEnd: (_) {
                resetTextColor(isStarting: true);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.startingAirport.airportName.isEmpty
                      ? Column(
                          children: [
                            Text(
                              'From',
                              style: TextStyle(
                                  color: destinationTextColor, fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Destination',
                              style: TextStyle(
                                color: destinationTextColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                              'From',
                              style: TextStyle(
                                  color: startingTextColor, fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.startingAirport.shortCode,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: startingTextColor,
                              ),
                            ),
                            Text(
                              widget.startingAirport.city,
                              style: TextStyle(
                                  color: startingTextColor, fontSize: 14),
                            ),
                            Text(
                              widget.startingAirport.airportName,
                              style: TextStyle(
                                color: startingTextColor,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.swap_horizontal_circle,
              color: Colors.white,
              size: 30,
            ),
            onPressed: swapAirports,
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
              onLongPress: () {
                changeTextColorOnLongPress(isStarting: false);
              },
              onLongPressEnd: (_) {
                resetTextColor(isStarting: false);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.destinationAirport.airportName.isEmpty
                      ? Column(
                          children: [
                            Text(
                              'To',
                              style: TextStyle(
                                  color: destinationTextColor, fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Select Destination',
                              style: TextStyle(
                                color: destinationTextColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                              'To',
                              style: TextStyle(
                                color: destinationTextColor,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.destinationAirport.shortCode,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: destinationTextColor,
                              ),
                            ),
                            Text(
                              widget.destinationAirport.city,
                              style: TextStyle(
                                color: destinationTextColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget.destinationAirport.airportName,
                              style: TextStyle(
                                color: destinationTextColor,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
