import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  LocationWidget({super.key, required this.deviceSize});
  Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'From',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'ADD',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Addis Ababa',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                'Bole International Airport',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Icon(
            Icons.swap_horiz,
            color: Colors.white,
            size: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'To',
                style: TextStyle(color: Colors.white, fontSize: 16),
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
          ),
        ],
      ),
    );
  }
}
