import 'package:flutter/material.dart';
import 'package:guzo_go_clone/presentation/home/widgets/location.dart';
import 'package:guzo_go_clone/presentation/home/widgets/trip_type.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oneWay = false;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: deviceSize.width * 0.05,
              vertical: deviceSize.height * 0.05,
            ),
            color: const Color(0xFF1f1b67),
            height: deviceSize.height * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    SizedBox(
                      height: deviceSize.height * 0.1,
                      child: Image.asset('assets/guzo_go.jpg'),
                    ),
                    const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    )
                  ],
                ),
                TripType(deviceSize: deviceSize, oneWay: oneWay),
                LocationWidget(deviceSize: deviceSize),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
