import 'package:flutter/material.dart';
import 'package:guzo_go_clone/presentation/airport/widget/no_airport_available.dart';
import 'package:provider/provider.dart';

import '../provider/select_airport_provider.dart';

class SelectAirportPage extends StatelessWidget {
  const SelectAirportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final airportProvider = Provider.of<AirportProvider>(context);
    Size deviceSize = MediaQuery.of(context).size;

    Future.delayed(const Duration(seconds: 4), () {
      if (airportProvider.isLoading &&
          airportProvider.filteredAirports.isEmpty) {
        airportProvider.retryFetchAirportsWithDelay();
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: deviceSize.height * 0.15,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Select Airport',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: deviceSize.width * 0.045,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: deviceSize.width * 0.04,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: deviceSize.height * 0.05,
              child: TextField(
                onChanged: (value) {
                  airportProvider.filterAirports(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color.fromARGB(255, 223, 223, 223),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.045),
            child: Text(
              'Direct Airports',
              style: TextStyle(
                fontSize: deviceSize.width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          airportProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : airportProvider.filteredAirports.isEmpty
                  ? NoAirportAvailable(
                      onTryAgain: () {
                        airportProvider.retryFetchAirportsWithDelay();
                      },
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: airportProvider.filteredAirports.length,
                        itemBuilder: (context, index) {
                          final airport =
                              airportProvider.filteredAirports[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.airplanemode_active),
                                title: Text(
                                  '${airport.city}, ${airport.airportName} (${airport.shortCode})',
                                ),
                              ),
                              Divider(
                                indent: deviceSize.width * 0.045,
                                endIndent: deviceSize.width * 0.045,
                                thickness: 0.8,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
