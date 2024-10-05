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
                    color:
                        const Color.fromARGB(255, 10, 16, 72).withOpacity(0.8),
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
