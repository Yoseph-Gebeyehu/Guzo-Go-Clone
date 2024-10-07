import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/model/trip_date.dart';
import 'package:guzo_go_clone/presentation/date-selector/screen/trip_date_selector_page.dart';

// ignore: must_be_immutable
class TripDateWidget extends StatelessWidget {
  TripDateWidget({
    super.key,
    required this.departureDate,
    required this.returnDate,
  });
  TripDate departureDate;
  TripDate returnDate;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TripDateSelectorPage(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(left: deviceSize.width * 0.04),
                  width: deviceSize.width * 0.45,
                  child: tripDateMethod(
                    deviceSize,
                    'Departure Date',
                    context,
                    departureDate.day,
                    departureDate.month,
                    departureDate.date,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const VerticalDivider(
                thickness: 0.4,
                color: Colors.grey,
                width: 0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TripDateSelectorPage(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(left: deviceSize.width * 0.04),
                  width: deviceSize.width * 0.45,
                  child: tripDateMethod(
                    deviceSize,
                    'Return Date',
                    context,
                    returnDate.day,
                    returnDate.month,
                    returnDate.date,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 0,
          thickness: 0.4,
        ),
      ],
    );
  }

  Column tripDateMethod(
    Size deviceSize,
    String label,
    BuildContext context,
    String day,
    String month,
    String weekday,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(label),
        Row(
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: deviceSize.width * 0.12,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(width: deviceSize.width * 0.025),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  month.substring(0, 3),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: deviceSize.width * 0.04,
                  ),
                ),
                Text(
                  weekday,
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.036,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
